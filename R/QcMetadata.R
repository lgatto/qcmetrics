.QcMetadata <- setClass("QcMetadata",
                        slots = list(metadata = "list"))

QcMetadata <- function(metadata) {
    stopifnot(class(metadata) == "list")
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
          function(x) metadata_txt(x))


setMethod("metadata", "QcMetadata",
          function(object) object@metadata)


setReplaceMethod("metadata",
                 signature(object="QcMetadata", value="list"),
                 function(object, value) {
                     object@metadata <- value
                     object
                 })

setMethod("length", "QcMetadata",
          function(x) length(mdata(x)))
