

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
##' @import github
##' @importFrom RJSONIO toJSON
setMethod("publishManifest", c(manifest = "PkgManifest",
                               dest = "GistDest"),
          function(manifest, dest, desc, ctx, ...) {
              .publishManifest(man = manifest,
                               desc = desc,
                               ctx = ctx)
          })

.publishManifest = function(man, desc,
    ctx,
    ...) {
    if(missing(ctx))
        ctx = interactive.login(.client_id(), .client_secret(), scopes = "gist")
    fil = publishManifest(man, tempfile(pattern = "manifest"))
    txt = paste(readLines(fil), collapse = "\n")
    payload = list(description=desc,
        public = TRUE,
        files = list("manifest.rman" = list(
                         content = txt)))
    json = toJSON(payload)
    res = create.gist(json, ctx)
    if(!res$ok)
        stop("failed to create gist")
    ##    res$content$files$manifest.rman$raw_url
    res$content$html_url
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
