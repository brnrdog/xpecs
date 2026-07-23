// Build the reativa (OCaml + Melange) component bundle consumed by the website's
// "Reativa" preview, and drop it next to the website sources.
//
// The components live in the @prescriptive/reativa package (packages/reativa); this
// script just delegates to that package's build (clone reativa → dune build
// @melange → esbuild bundle) and copies the resulting dist/reativa.bundle.js
// into website/src/reativa.bundle.js, overwriting the checked-in placeholder.
//
// Requires: opam switch with `dune`, `melange`, `mlx` installed, plus git and
// esbuild. Not part of `npm run build`/CI's website build — invoked explicitly
// by `npm run reativa`.

import { execFileSync } from "node:child_process";
import { copyFileSync } from "node:fs";
import { resolve } from "node:path";
import { fileURLToPath } from "node:url";

const websiteDir = resolve(fileURLToPath(import.meta.url), "../..");
const repoRoot = resolve(websiteDir, "..");
const pkgDir = resolve(repoRoot, "packages/reativa");

// 1. Build @prescriptive/reativa (generates Contracts.ml, compiles with Melange, and
//    bundles to packages/reativa/dist/reativa.bundle.js).
execFileSync("npm", ["run", "build", "--workspace", "@prescriptive/reativa"], {
  cwd: repoRoot,
  stdio: "inherit",
});

// 2. Copy the built bundle next to the website sources (overwrites the
//    checked-in `built = false` placeholder with the real `built = true` one).
const src = resolve(pkgDir, "dist/reativa.bundle.js");
const dest = resolve(websiteDir, "src/reativa.bundle.js");
copyFileSync(src, dest);

console.log(`\n✓ reativa bundle copied to ${dest}`);
