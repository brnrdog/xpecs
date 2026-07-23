// Builds the distributable token artifacts from the framework's source of truth
// (../../../tokens/{tokens,themes}.json) into ./dist:
//   variables.css  — :root { --ux-* } custom properties (framework-agnostic)
//   tailwind.css   — a Tailwind v4 @theme preset (bg-action, text-ink, …) + the mirror
//   themes.css     — theme + light/dark overlays keyed by [data-theme] / [data-mode]
//   tokens.js/.d.ts — resolved tokens as a typed JS object (nested + flat)
//   tokens.json / themes.json — the raw sources, for tooling
import { readFileSync, writeFileSync, mkdirSync, copyFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { themeVarFor } from "./token-vars.mjs";

const here = dirname(fileURLToPath(import.meta.url));
const root = join(here, "..", "..", "..");
const srcTokens = join(root, "tokens", "tokens.json");
const srcThemes = join(root, "tokens", "themes.json");
const dist = join(here, "..", "dist");
mkdirSync(dist, { recursive: true });

const tokens = JSON.parse(readFileSync(srcTokens, "utf8"));

// Flatten to { "color.neutral.900": { type, value }, … }, inheriting $type.
const flat = {};
(function walk(node, path, inheritedType) {
  const type = node.$type || inheritedType;
  if (Object.prototype.hasOwnProperty.call(node, "$value")) {
    flat[path.join(".")] = { type, value: node.$value };
    return;
  }
  for (const [k, v] of Object.entries(node)) {
    if (k.startsWith("$")) continue;
    walk(v, [...path, k], type);
  }
})(tokens, [], undefined);

const aliasRef = (v) => (typeof v === "string" && /^\{(.+)\}$/.test(v) ? v.slice(1, -1) : null);
function resolve(value, seen = new Set()) {
  const ref = aliasRef(value);
  if (ref) {
    if (seen.has(ref) || !flat[ref]) return value;
    seen.add(ref);
    return resolve(flat[ref].value, seen);
  }
  return value;
}
function cssValue(type, rawValue) {
  const value = resolve(rawValue);
  switch (type) {
    case "fontFamily":
      return (Array.isArray(value) ? value : [value]).map((f) => (/\s/.test(f) ? `"${f}"` : f)).join(", ");
    case "shadow": {
      const list = Array.isArray(value) ? value : [value];
      return list.map((s) => `${s.offsetX} ${s.offsetY} ${s.blur} ${s.spread || "0"} ${s.color}`).join(", ");
    }
    default:
      return String(value);
  }
}
const uxVar = (path) => `--ux-${path.replace(/\./g, "-")}`;
// Aliases stay live so overriding a base token cascades through the semantic graph.
function uxValueFor(tok) {
  const ref = aliasRef(tok.value);
  return ref ? `var(${uxVar(ref)})` : cssValue(tok.type, tok.value);
}
function themeValueFor(tok) {
  const ref = aliasRef(tok.value);
  if (ref) {
    const v = themeVarFor(ref);
    if (v) return `var(${v})`;
  }
  return cssValue(tok.type, tok.value);
}

// --- variables.css : the --ux-* custom properties ---------------------------
const rootLines = Object.entries(flat).map(([p, t]) => `  ${uxVar(p)}: ${uxValueFor(t)};`);
const banner = `/* GENERATED — @prescriptive/tokens. Source: framework tokens.json (DTCG). */`;
writeFileSync(join(dist, "variables.css"), `${banner}\n:root {\n${rootLines.join("\n")}\n}\n`);

// --- tailwind.css : Tailwind v4 @theme preset + the --ux-* mirror -----------
const themeLines = [];
for (const [path, tok] of Object.entries(flat)) {
  const v = themeVarFor(path);
  if (v) themeLines.push(`  ${v}: ${themeValueFor(tok)};`);
}
writeFileSync(
  join(dist, "tailwind.css"),
  `${banner}\n@theme {\n${themeLines.join("\n")}\n}\n\n:root {\n${rootLines.join("\n")}\n}\n`,
);

// --- themes.css : theme + light/dark overlays -------------------------------
const themesSrc = JSON.parse(readFileSync(srcThemes, "utf8"));
const overrideBlock = (selector, map) => {
  const lines = [];
  for (const [path, value] of Object.entries(map || {})) {
    lines.push(`  ${uxVar(path)}: ${value};`);
    const tv = themeVarFor(path);
    if (tv) lines.push(`  ${tv}: ${value};`);
  }
  return lines.length ? `${selector} {\n${lines.join("\n")}\n}\n` : "";
};
const themeCss = [banner, "/* Apply with data-theme / data-mode on :root (or any ancestor). */"];
for (const t of themesSrc.themes || []) {
  if (Object.keys(t.tokens || {}).length) themeCss.push(overrideBlock(`[data-theme="${t.id}"]`, t.tokens));
}
themeCss.push(overrideBlock(`[data-mode="dark"]`, (themesSrc.modes || {}).dark));
for (const t of themesSrc.themes || []) {
  if (Object.keys(t.dark || {}).length)
    themeCss.push(overrideBlock(`[data-theme="${t.id}"][data-mode="dark"]`, t.dark));
}
writeFileSync(join(dist, "themes.css"), themeCss.filter(Boolean).join("\n"));

// --- tokens.js / tokens.d.ts : resolved tokens as data ----------------------
const flatResolved = {};
const nested = {};
for (const [path, tok] of Object.entries(flat)) {
  const val = cssValue(tok.type, tok.value);
  flatResolved[path] = val;
  const parts = path.split(".");
  let cur = nested;
  parts.forEach((k, i) => {
    if (i === parts.length - 1) cur[k] = val;
    else cur = cur[k] ||= {};
  });
}
const themeList = (themesSrc.themes || []).map((t) => ({ id: t.id, label: t.label, swatches: t.swatches || [] }));
writeFileSync(
  join(dist, "tokens.js"),
  `${banner}\nexport const tokens = ${JSON.stringify(nested, null, 2)};\n` +
    `export const flat = ${JSON.stringify(flatResolved, null, 2)};\n` +
    `export const themes = ${JSON.stringify(themeList, null, 2)};\n` +
    `export default tokens;\n`,
);
writeFileSync(
  join(dist, "tokens.d.ts"),
  `export declare const tokens: Record<string, any>;\n` +
    `export declare const flat: Record<string, string>;\n` +
    `export declare const themes: { id: string; label: string; swatches: string[] }[];\n` +
    `declare const _default: typeof tokens;\nexport default _default;\n`,
);

copyFileSync(srcTokens, join(dist, "tokens.json"));
copyFileSync(srcThemes, join(dist, "themes.json"));

console.log(
  `@prescriptive/tokens: ${Object.keys(flat).length} tokens, ${themeList.length} themes → dist/`,
);
