// Generates INDEX.md from the spec markdown frontmatter, so the registry
// can never drift from the specs. Run `npm run index` (or `npm run gen`).
import { readFileSync, writeFileSync, readdirSync } from "node:fs";
import { join, dirname, basename } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const specsDir = join(here, "..", "specs");
const outFile = join(here, "..", "INDEX.md");

// dir → { layer value, heading }
const layers = [
  ["elements", "element", "Elements"],
  ["components", "component", "Components"],
  ["blocks", "block", "Blocks"],
  ["pages", "page", "Pages"],
  ["flows", "flow", "Flows"],
];

function frontmatter(raw) {
  const m = raw.match(/^---\n([\s\S]*?)\n---/);
  if (!m) return {};
  const meta = {};
  for (const line of m[1].split("\n")) {
    const mm = line.match(/^([a-zA-Z]+):\s*(.*)$/);
    if (mm) meta[mm[1]] = mm[2].trim();
  }
  return meta;
}

const sections = [];
for (const [dir, , heading] of layers) {
  let files;
  try {
    files = readdirSync(join(specsDir, dir)).filter((f) => f.endsWith(".md"));
  } catch {
    continue;
  }
  const rows = files
    .map((f) => {
      const meta = frontmatter(readFileSync(join(specsDir, dir, f), "utf8"));
      const id = meta.id || basename(f, ".md");
      return {
        id,
        title: meta.title || id,
        version: meta.version || "",
        status: meta.status || "",
        summary: meta.summary || "",
        path: `specs/${dir}/${f}`,
      };
    })
    .sort((a, b) => a.title.localeCompare(b.title));
  if (rows.length === 0) continue;
  const body = rows
    .map(
      (r) =>
        `| [${r.title}](${r.path}) | \`${r.id}\` | ${r.version} | ${r.status} | ${r.summary} |`,
    )
    .join("\n");
  sections.push(
    `## ${heading}\n\n| Spec | id | Version | Status | Summary |\n| --------- | -- | ------- | ------ | ------- |\n${body}`,
  );
}

// Behavior traits (cross-cutting interaction contracts).
let traitSection = "";
try {
  const traitsDir = join(here, "..", "traits");
  const rows = readdirSync(traitsDir)
    .filter((f) => f.endsWith(".md"))
    .map((f) => {
      const meta = frontmatter(readFileSync(join(traitsDir, f), "utf8"));
      const id = meta.id || basename(f, ".md");
      return { id, title: meta.title || id, summary: meta.summary || "", path: `traits/${f}` };
    })
    .sort((a, b) => a.title.localeCompare(b.title));
  if (rows.length) {
    const body = rows
      .map((r) => `| [${r.title}](${r.path}) | \`${r.id}\` | ${r.summary} |`)
      .join("\n");
    traitSection = `\n\n## Behaviors\n\nCross-cutting interaction contracts shared by many specs (see \`traits/\`).\n\n| Trait | id | Summary |\n| ----- | -- | ------- |\n${body}`;
  }
} catch {
  /* no traits dir */
}

const out = `<!-- GENERATED FILE — do not edit by hand. Run \`npm run index\`. -->

# Spec Index

A registry of every spec in the collection, generated from the specs'
frontmatter (\`npm run index\`).

${sections.join("\n\n")}${traitSection}
`;

writeFileSync(outFile, out);
console.log(`Wrote INDEX.md (${sections.length} layers)`);
