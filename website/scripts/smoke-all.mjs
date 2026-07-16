import { chromium } from "playwright-core";
import { readFileSync } from "node:fs";

// Pull every id from the generated data module.
const data = readFileSync(new URL("../src/ArchetypesData.res", import.meta.url), "utf8");
const ids = [...data.matchAll(/^\s*id: "([^"]+)",/gm)].map((m) => m[1]);

const base = "http://localhost:4173";
const browser = await chromium.launch();
const page = await browser.newPage();
const errors = [];
page.on("console", (m) => {
  if (m.type() === "error") errors.push(`${m.text()}`);
});
page.on("pageerror", (e) => errors.push(`pageerror @ ${page.url()}: ${e.message}`));

let live = 0;
let placeholder = 0;
let empty = 0;
for (const id of ids) {
  await page.goto(`${base}/a/${id}`, { waitUntil: "networkidle" });
  await page.waitForTimeout(40);
  const hasLive = (await page.locator(".preview-surface").count()) > 0;
  const hasPlaceholder = (await page.getByText("coming soon").count()) > 0;
  const title = (await page.locator("h1").first().textContent()) || "";
  if (!title.trim()) {
    empty++;
    console.log(`EMPTY  ${id}`);
  }
  if (hasLive) live++;
  else if (hasPlaceholder) placeholder++;
}

await browser.close();
console.log(`\nRoutes: ${ids.length}`);
console.log(`Live examples:   ${live}`);
console.log(`Placeholders:    ${placeholder}`);
console.log(`Empty pages:     ${empty}`);
console.log(errors.length ? `\nConsole errors (${errors.length}):\n  ${[...new Set(errors)].join("\n  ")}` : "\nNo console errors across all routes.");
if (errors.length || empty) process.exitCode = 1;
