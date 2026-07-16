// Generates src/ArchetypesData.res from the archetype markdown files.
// Parses the YAML frontmatter (simple, line-based) and extracts the first
// paragraph of the "Intent" section, then emits a typed ReScript module.
import { readFileSync, writeFileSync, readdirSync } from "node:fs";
import { join, dirname, basename } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const archetypesDir = join(here, "..", "..", "archetypes");
const outFile = join(here, "..", "src", "ArchetypesData.res");

const layers = ["elements", "components", "pages", "flows"];

function parseInlineArray(value) {
  const inner = value.trim().replace(/^\[/, "").replace(/\]$/, "").trim();
  if (inner === "") return [];
  return inner
    .split(",")
    .map((s) => s.trim())
    .filter((s) => s.length > 0);
}

function parseFrontmatter(raw) {
  const m = raw.match(/^---\n([\s\S]*?)\n---\n([\s\S]*)$/);
  if (!m) return null;
  const [, fm, body] = m;
  const meta = {};
  for (const line of fm.split("\n")) {
    const mm = line.match(/^([a-zA-Z]+):\s*(.*)$/);
    if (!mm) continue;
    const [, key, val] = mm;
    if (val.startsWith("[")) meta[key] = parseInlineArray(val);
    else meta[key] = val.trim();
  }
  return { meta, body };
}

function extractSection(body, heading) {
  const re = new RegExp(`^##\\s+${heading}\\s*$`, "m");
  const start = body.match(re);
  if (!start) return "";
  const rest = body.slice(start.index + start[0].length);
  const next = rest.search(/^##\s+/m);
  const section = next === -1 ? rest : rest.slice(0, next);
  // First non-empty paragraph, stripped of markdown emphasis/links.
  const paras = section
    .split(/\n\s*\n/)
    .map((p) => p.trim())
    .filter((p) => p && !p.startsWith("<!--"));
  const first = paras[0] || "";
  return first
    .replace(/\s*\n\s*/g, " ")
    .replace(/\*\*(.+?)\*\*/g, "$1")
    .replace(/\*(.+?)\*/g, "$1")
    .replace(/`(.+?)`/g, "$1")
    .replace(/\[(.+?)\]\((.+?)\)/g, "$1")
    .replace(/_(.+?)_/g, "$1")
    .trim();
}

const records = [];
for (const layerDir of layers) {
  let files;
  try {
    files = readdirSync(join(archetypesDir, layerDir)).filter((f) =>
      f.endsWith(".md"),
    );
  } catch {
    continue;
  }
  for (const file of files.sort()) {
    const raw = readFileSync(join(archetypesDir, layerDir, file), "utf8");
    const parsed = parseFrontmatter(raw);
    if (!parsed) continue;
    const { meta, body } = parsed;
    records.push({
      id: meta.id || basename(file, ".md"),
      title: meta.title || "",
      layer: meta.layer || "",
      status: meta.status || "",
      version: meta.version || "",
      summary: meta.summary || "",
      tags: meta.tags || [],
      aliases: meta.aliases || [],
      composedOf: meta.composedOf || [],
      usedBy: meta.usedBy || [],
      related: meta.related || [],
      intent: extractSection(body, "Intent"),
    });
  }
}

const layerOrder = { element: 0, component: 1, page: 2, flow: 3 };
records.sort(
  (a, b) =>
    (layerOrder[a.layer] ?? 9) - (layerOrder[b.layer] ?? 9) ||
    a.title.localeCompare(b.title),
);

const s = (v) => JSON.stringify(v); // valid ReScript string literal
const arr = (xs) => `[${xs.map(s).join(", ")}]`;

const body = records
  .map(
    (r) => `  {
    id: ${s(r.id)},
    title: ${s(r.title)},
    layer: ${s(r.layer)},
    status: ${s(r.status)},
    version: ${s(r.version)},
    summary: ${s(r.summary)},
    tags: ${arr(r.tags)},
    aliases: ${arr(r.aliases)},
    composedOf: ${arr(r.composedOf)},
    usedBy: ${arr(r.usedBy)},
    related: ${arr(r.related)},
    intent: ${s(r.intent)},
  }`,
  )
  .join(",\n");

const out = `// GENERATED FILE — do not edit by hand.
// Run \`npm run registry\` (scripts/generate-registry.mjs) to regenerate.

type archetype = {
  id: string,
  title: string,
  layer: string,
  status: string,
  version: string,
  summary: string,
  tags: array<string>,
  aliases: array<string>,
  composedOf: array<string>,
  usedBy: array<string>,
  related: array<string>,
  intent: string,
}

let all: array<archetype> = [
${body},
]
`;

writeFileSync(outFile, out);
console.log(`Wrote ${records.length} archetypes to ${outFile}`);
