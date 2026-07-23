// Bridges the reativa (OCaml + Melange) component implementations into the
// ReScript/Xote website. The components live in the @xpecs/reativa package
// (packages/reativa/src/*.mlx) and are compiled + bundled to
// website/src/reativa.bundle.js by `npm run reativa`.
//
// Until that bundle is built, a checked-in placeholder stands in with
// `built = false`, so the site still compiles and the "Reativa" tab renders a
// short build hint instead of the live components.

@module("./reativa.bundle.js") external built: bool = "built"
@module("./reativa.bundle.js") external exampleIds: array<string> = "example_ids"
@module("./reativa.bundle.js")
external mountExampleRaw: (string, string) => unit = "mount_example"

// The specs that have a reativa implementation — these get a "Reativa" preview
// alongside the Xote one. Sourced from the bundle so the two never drift.
let ids = exampleIds
let has = id => ids->Array.includes(id)

// The dom id of the container the reativa runtime mounts a spec's example into.
let containerId = id => "reativa-example-" ++ id

// Mount a spec's reativa example into its container. Deferred a tick so the
// Xote-rendered container node is in the DOM before reativa looks it up.
let mount = id => Ui.setTimeout(() => mountExampleRaw(id, containerId(id)), 0)
