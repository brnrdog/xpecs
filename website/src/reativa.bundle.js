// PLACEHOLDER — not the real bundle.
//
// The reativa (OCaml + Melange) Xpecs examples are compiled from
// website/reativa/xpecs_reativa.mlx. Building them needs the OCaml toolchain
// (opam + melange), which isn't part of the ReScript/Vite website build, so
// this checked-in stub keeps the site building and the "Reativa" tab present
// (showing a build hint) until the real bundle is generated.
//
// To generate the real bundle (overwrites this file):
//
//     cd website && npm run reativa
//
// See website/reativa/README.md for the toolchain setup.

export const built = false;
export const example_ids = ["button", "badge", "alert", "cta-section"];
export function mount_example(_specId, _containerId) {
  /* no-op until the Melange bundle is built */
}
