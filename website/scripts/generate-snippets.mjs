// Generates src/ExampleSource.res — the ReScript source of every example in
// Examples.res, keyed by archetype id — so each detail page can show the exact
// implementation that produces its live preview. Examples.res (and the shared
// Kit) stay the single source of truth; this just extracts them. Any reusable
// Kit component an example references is prepended (wrapped in `module Kit`) so
// each snippet is self-contained and shows the reuse.
import { readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const srcDir = join(here, "..", "src");
const examplesSrc = readFileSync(join(srcDir, "Examples.res"), "utf8");
const kitSrc = readFileSync(join(srcDir, "Kit.res"), "utf8");
const outFile = join(srcDir, "ExampleSource.res");

// Find the matching close brace for the block opening at `start` ("{"),
// skipping strings and comments so their braces don't count.
function matchBrace(s, start) {
  let depth = 0;
  let mode = "code";
  for (let i = start; i < s.length; i++) {
    const c = s[i];
    const c2 = s[i + 1];
    if (mode === "code") {
      if (c === '"') mode = "dq";
      else if (c === "`") mode = "bt";
      else if (c === "/" && c2 === "/") { mode = "lc"; i++; }
      else if (c === "/" && c2 === "*") { mode = "bc"; i++; }
      else if (c === "{") depth++;
      else if (c === "}") { depth--; if (depth === 0) return i; }
    } else if (mode === "dq") {
      if (c === "\\") i++;
      else if (c === '"') mode = "code";
    } else if (mode === "bt") {
      if (c === "\\") i++;
      else if (c === "`") mode = "code";
    } else if (mode === "lc") {
      if (c === "\n") mode = "code";
    } else if (mode === "bc") {
      if (c === "*" && c2 === "/") { mode = "code"; i++; }
    }
  }
  return s.length - 1;
}

// Extract every top-level `module Name = { ... }` block into { name: text }.
function extractModules(src) {
  const mods = {};
  const re = /^module\s+(\w+)\s*=\s*\{/gm;
  let m;
  while ((m = re.exec(src))) {
    const open = src.indexOf("{", m.index);
    mods[m[1]] = src.slice(m.index, matchBrace(src, open) + 1);
  }
  return mods;
}

const exampleMods = extractModules(examplesSrc);
const kitMods = extractModules(kitSrc);

// Kit component names referenced (Kit.Foo) within a chunk of code.
function kitRefs(text) {
  return [...new Set([...text.matchAll(/\bKit\.(\w+)/g)].map((m) => m[1]))].filter(
    (n) => kitMods[n],
  );
}

// Dependency-ordered closure of Kit components an example needs.
function collectKit(seedRefs) {
  const seen = new Set();
  const order = [];
  const visit = (name) => {
    if (seen.has(name) || !kitMods[name]) return;
    seen.add(name);
    for (const dep of kitRefs(kitMods[name])) visit(dep);
    order.push(name);
  };
  seedRefs.forEach(visit);
  return order;
}

const indent = (text) =>
  text
    .split("\n")
    .map((l) => (l.length ? "  " + l : l))
    .join("\n");

// Map archetype id -> example module name from the `get` switch.
const idToModule = {};
for (const m of examplesSrc.matchAll(/\|\s*"([^"]+)"\s*=>\s*Some\(<(\w+)\s*\/>\)/g)) {
  idToModule[m[1]] = m[2];
}

const s = (v) => JSON.stringify(v); // valid ReScript string literal

const arms = Object.entries(idToModule)
  .map(([id, mod]) => {
    const code = exampleMods[mod];
    const kit = collectKit(kitRefs(code));
    const prefix =
      kit.length > 0
        ? "module Kit = {\n" + kit.map((n) => indent(kitMods[n])).join("\n\n") + "\n}\n\n"
        : "";
    return `  | ${s(id)} => Some(${s(prefix + code)})`;
  })
  .join("\n");

const out = `// GENERATED FILE — do not edit by hand.
// Run \`npm run snippets\` (scripts/generate-snippets.mjs) to regenerate.
// Source is extracted verbatim from Examples.res and the shared Kit (Kit.res).

let get = (id: string): option<string> =>
  switch id {
${arms}
  | _ => None
  }
`;

writeFileSync(outFile, out);
console.log(`Wrote ${Object.keys(idToModule).length} snippets to ${outFile}`);
