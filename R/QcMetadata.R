.QcMetadata <- setClass("QcMetadata",
                        slots = list(metadata = "list"))

checkMetaDataListNames <- function(metadata) {
    nms <- names(metadata)
    if (is.null(nms)) 
        stop("Your metadata must be named.")    
    nonms <- (nms == "") | is.na(nms)
    if (any(nonms))
        stop("Empty names or NA are not permitted.")
    return(TRUE)
}

QcMetadata <- function(metadata) {
    stopifnot(class(metadata) == "list")
    checkMetaDataListNames(metadata)
    .QcMetadata(metadata = metadata)
}

setMethod("show", "QcMetadata",
          function(object) {
              cat("Object of class \"", class(object), "\"\n", sep="")
              n <- length(object@metadata)
              if (n == 0) n <- "no"
              cat(" containing", n , "variables.\n")              
          })

setMethod("print", "QcMetadata",
          function(x) {
              x <- metadata(x)
              nms <- names(x)
              if (is.null(nms))
                  nms <- paste0("Metadata ", 1:length(x))
              for (i in seq_along(x)) {        
                  cat(nms[i], "\n ")
                  print(x[[i]])        
              }
          })

setMethod("metadata", "QcMetadata",
          function(x) x@metadata)

setMethod("mdata", "QcMetadata",
          function(object) metadata(object))

setReplaceMethod("metadata",
                 signature(x="QcMetadata", value="list"),
                 function(x, value) {
                     x@metadata <- value
                     x
                 })

setReplaceMethod("mdata",
                 signature(object="QcMetadata", value="list"),
                 function(object, value) {
                     object@metadata <- value
                     object
                 })

setMethod("length", "QcMetadata",
          function(x) length(mdata(x)))

setMethod("[","QcMetadata",
          function(x, i="numeric", j="missing", drop="missing") {
              x@metadata <- x@metadata[i]
              x
        })


setMethod("[[","QcMetadata",
          function(x, i="numeric", j="missing" ,drop="missing") 
          x@metadata[[i]])

setMethod("names", "QcMetadata",
          function(x) names(x@metadata))

setReplaceMethod("names",
                 signature(x="QcMetadata", value="character"),
                 function(x, value) {
                     names(x@metadata) <- value
                     x
                 })

