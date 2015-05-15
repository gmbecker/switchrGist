##' @import httpuv
##' @import gistr


##' 
##'
##' publish a manifest to Github in the form of a gist
##'
##' @param man The manifest to be published
##' @param desc description to apply to the Gist
##' @param ctx the github context to be used. By defualt this will open a Web
##' browser and ask you to authorize switchr to modify your gists.
##' @param ... unused.
##' @return the url to access the raw 
##' @export
##' @importFrom RJSONIO toJSON
setMethod("publishManifest", c(manifest = "PkgManifest",
                               dest = "GistDest"),
          function(manifest, dest, desc, ...) {
              .publishManifest2(man = manifest,
                               desc = desc)
          })

setMethod("publishManifest", c(manifest = "SessionManifest",
                               dest = "GistDest"),
          function(manifest, dest, desc, ...) {
              .publishManifest2(man = manifest,
                               desc = desc)
          })

.publishManifest2 = function(man, desc = "An R package manifest", ...) {
    fil = tempfile(pattern = "manifest.rman")
    fil = publishManifest(man, fil)
    gist_create(files = fil, description = desc)
}

    




##XXX todo: make these more secure

.client_id = function() {
    load(system.file("data/sysdata.rda", package = "switchrGist"))
    id
}

.client_secret = function() {
    load(system.file("data/sysdata.rda", package = "switchrGist"))
    sec
}
