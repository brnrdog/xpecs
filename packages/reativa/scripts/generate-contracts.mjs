// Generates src/Contracts.ml from the `## API` blocks in the spec markdown.
// For every enum prop it emits an OCaml polymorphic-variant type, grouped in a
// module named after the spec. Components annotate their props with these
// types, so the OCaml compiler itself enforces that the implementation stays in
// sync with the contract's allowed values.
//
// This is the OCaml counterpart of packages/xote/scripts/generate-contracts.mjs
// (which emits ReScript polymorphic variants for @xpecs/xote); both read the
// same specs so the two implementations expose the same contract types.
import { readFileSync, writeFileSync, readdirSync, mkdirSync } from "node:fs";
import { join, dirname, basename } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const specsDir = join(here, "..", "..", "..", "specs");
const outFile = join(here, "..", "src", "Contracts.ml");
const layers = ["elements", "components", "blocks", "pages", "flows"];

// OCaml keywords that can't be bare type names — suffixed with `_` if hit.
const reserved = new Set([
  "and", "as", "assert", "begin", "class", "constraint", "do", "done", "downto",
  "else", "end", "exception", "external", "false", "for", "fun", "function",
  "functor", "if", "in", "include", "inherit", "initializer", "lazy", "let",
  "match", "method", "module", "mutable", "new", "nonrec", "object", "of", "open",
  "or", "private", "rec", "sig", "struct", "then", "to", "true", "try", "type",
  "val", "virtual", "when", "while", "with",
]);
const typeName = (n) => (reserved.has(n) ? `${n}_` : n);
const pascal = (id) =>
  id
    .split("-")
    .map((p) => p.charAt(0).toUpperCase() + p.slice(1))
    .join("");

function apiOf(body) {
  const m = body.match(/^##\s+API\s*$/m);
  if (!m) return null;
  const fence = body.slice(m.index).match(/```json\s*([\s\S]*?)```/);
  if (!fence) return null;
  return JSON.parse(fence[1]);
}

const modules = [];
for (const layerDir of layers) {
  let files;
  try {
    files = readdirSync(join(specsDir, layerDir)).filter((f) => f.endsWith(".md"));
  } catch {
    continue;
  }
  for (const file of files.sort()) {
    const raw = readFileSync(join(specsDir, layerDir, file), "utf8");
    const api = apiOf(raw);
    if (!api || !Array.isArray(api.props)) continue;
    const enums = api.props.filter((p) => p.type === "enum" && p.values?.length);
    if (enums.length === 0) continue;
    const id = basename(file, ".md");
    const types = enums
      .map(
        (p) =>
          `  type ${typeName(p.name)} = [ ${p.values.map((v) => `\`${v}`).join(" | ")} ]`,
      )
      .join("\n");
    modules.push(`module ${pascal(id)} = struct\n${types}\nend`);
  }
}

const out = `(* GENERATED FILE — do not edit by hand.
   Run \`npm run contracts\` (scripts/generate-contracts.mjs) to regenerate.
   Types are derived from the \`## API\` contracts in the spec markdown. *)

${modules.join("\n\n")}
`;

mkdirSync(dirname(outFile), { recursive: true });
writeFileSync(outFile, out);
console.log(`Wrote ${modules.length} contract module(s) to ${outFile}`);
