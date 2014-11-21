##' @import github
##' @importFrom RJSONIO toJSON
##' publishManifest
##'
##' publish a manifest to Github in the form of a gist
##'
##' @param man The manifest to be published
##' @param ctx the github context to be used. By defualt this will open a Web
##' browser and ask you to authorize switchr to modify your gists.
##' @param ... unused.
##' @return the url to access the raw 
##' @export
publishManifest = function(man, desc,
    ctx,
    ...) {
    if(missing(ctx))
        ctx = interactive.login(.client_id(), .client_secret(), scopes = "gist")
    fil = saveManifest(man, tempfile(pattern = "manifest"))
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
