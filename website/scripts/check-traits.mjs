// Checks that every spec claiming a behavior trait actually declares the
// keyboard keys that trait requires, in its `## API` a11y.keyboard. A trait is a
// promise ("this is dismissible"); this verifies the interface backs it up.
// Exits non-zero on a violation, so an unmet behavior claim fails the build.
import { readFileSync, readdirSync } from "node:fs";
import { join, dirname, basename } from "node:path";
import { fileURLToPath } from "node:url";

const here = dirname(fileURLToPath(import.meta.url));
const specsDir = join(here, "..", "..", "specs");
const traitsDir = join(here, "..", "..", "traits");
const layers = ["elements", "components", "blocks", "pages", "flows"];

function frontmatter(raw) {
  const m = raw.match(/^---\n([\s\S]*?)\n---/);
  if (!m) return {};
  const meta = {};
  for (const line of m[1].split("\n")) {
    const mm = line.match(/^([a-zA-Z]+):\s*(.*)$/);
    if (!mm) continue;
    const [, k, v] = mm;
    meta[k] = v.startsWith("[")
      ? v.replace(/^\[|\]$/g, "").split(",").map((s) => s.trim()).filter(Boolean)
      : v.trim();
  }
  return meta;
}

function apiKeyboard(raw) {
  const m = raw.match(/^##\s+API\s*$/m);
  if (!m) return null;
  const fence = raw.slice(m.index).match(/```json\s*([\s\S]*?)```/);
  if (!fence) return null;
  try {
    return JSON.parse(fence[1])?.a11y?.keyboard || [];
  } catch {
    return null;
  }
}

// Load trait key requirements.
const traits = {};
for (const f of readdirSync(traitsDir).filter((f) => f.endsWith(".md"))) {
  const meta = frontmatter(readFileSync(join(traitsDir, f), "utf8"));
  const id = meta.id || basename(f, ".md");
  traits[id] = { keys: meta.keys || [], match: meta.match || "all" };
}

let failures = 0;
let checked = 0;
for (const layer of layers) {
  let files;
  try {
    files = readdirSync(join(specsDir, layer)).filter((f) => f.endsWith(".md"));
  } catch {
    continue;
  }
  for (const file of files.sort()) {
    const raw = readFileSync(join(specsDir, layer, file), "utf8");
    const meta = frontmatter(raw);
    const claimed = meta.traits || [];
    if (claimed.length === 0) continue;
    const kb = apiKeyboard(raw);
    for (const tid of claimed) {
      const t = traits[tid];
      if (!t) {
        console.log(`✗ ${meta.id}: claims unknown trait \`${tid}\``);
        failures++;
        continue;
      }
      if (t.keys.length === 0) continue; // nothing to enforce (e.g. anchored)
      checked++;
      if (kb === null) {
        console.log(`✗ ${meta.id}: claims \`${tid}\` but has no API a11y.keyboard`);
        failures++;
        continue;
      }
      const has = (k) => kb.includes(k);
      const ok = t.match === "any" ? t.keys.some(has) : t.keys.every(has);
      if (!ok) {
        const missing = t.match === "any" ? `one of [${t.keys.join(", ")}]` : `[${t.keys.filter((k) => !has(k)).join(", ")}]`;
        console.log(`✗ ${meta.id}: claims \`${tid}\` but a11y.keyboard is missing ${missing} (has [${kb.join(", ")}])`);
        failures++;
      }
    }
  }
}

console.log(`\n${failures ? "✗" : "✓"} trait conformance: ${checked} claim(s) checked, ${failures} issue(s)`);
process.exitCode = failures ? 1 : 0;
