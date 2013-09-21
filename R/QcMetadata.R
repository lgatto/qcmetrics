.QcMetadata <- setClass("QcMetadata",
                        slots = list(metadata = "list"))

QcMetadata <- function(metadata = object) {
    stopifnot(class(metadata) == "list")
    .QcMetadata(metadata = metadata)
}

setMethod("show", "QcMetadata",
          function(object) {
              cat("Object of class \"", class(object), "\"\n", sep="")
              n <- length(object@metadata)              
              cat(" containing", n , "variables.\n")          
          })


setMethod("metadata", "QcMetadata",
          function(object) object@metadata)


setReplaceMethod("metadata",
                 signature(object="QcMetrics", value="list"),
                 function(object, value) {
                     object@metadata <- value
                     object
                 })
