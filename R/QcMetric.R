## setClassUnion("LogicalOrNULL",
##               c("NULL", "logical"))

qcshow <- function(object) {
    cat("Object of class \"", class(object), "\"\n", sep="")
    cat(" Name:", object@name, "\n")                 
    cat(" Status:", object@status, "\n")
    cat(" Data: ")
    if (length(qcdata(object)) == 0) cat("empty\n")
    else cat(qcdata(object), "\n")    
    invisible(NULL)
}


.QcMetric <- setClass("QcMetric",
                      slots = list(
                          name = "character",
                          qcdata = "environment",
                          plot = "function",
                          show = "function",
                          status = "logical"),
                      prototype = prototype(
                          name = "A QcMetric prototype",
                          status = NA,
                          qcdata = new.env(),
                          plot = function(x, ...) {
                              warning("No specific plot function defined")
                              invisible(NULL)
                          }, 
                          show = qcshow))

QcMetric <- function(...) {
    ans <- .QcMetric(...)
    ans@qcdata <- new.env()
    ans
}

setMethod("show", "QcMetric",
          function(object) object@show(object))

setReplaceMethod("show",
                 signature(object="QcMetric", value="function"),
                 function(object, value) {
                     object@show <- value
                     return(object)
                 })

setMethod("plot", c("QcMetric", "missing"), 
          function(x, y, ...) x@plot(x, ...))

setReplaceMethod("plot",
                 signature(object="QcMetric", value="function"),
                 function(object, value) {
                     object@plot <- value
                     object
                 })

setMethod("qcdata", c("QcMetric", "missing"), 
          function(object) ls(object@qcdata))

setMethod("qcdata", c("QcMetric", "character"), 
          function(object, x) {
              objs <- qcdata(object)
              if (!x %in% objs)
                  stop("No qcdata '", x, "' in object.")
              get(x, envir = object@qcdata)}
          )

setReplaceMethod("qcdata",
                 signature(object="QcMetric", value="ANY"),
                 function(object, var, value) {
                     if (missing(value) & is.environment(var)) {
                         object@qcdata <- var
                     } else {
                         objs <- qcdata(object)
                         if (var %in% objs)
                             message("Overwriting variable 'var'.")
                         assign(var,
                                value = value, 
                                envir = object@qcdata)
                     }
                     object
                 })

setMethod("status", "QcMetric",
          function(object) object@status)

setReplaceMethod("status", signature(object="QcMetric", value="logical"),
                 function(object, value) {
                     object@status <- value
                     object
                 })

setMethod("name", "QcMetric",
          function(object) object@name)

setReplaceMethod("name", signature(object="QcMetric", value="character"),
                 function(object, value) {
                     object@name <- value
                     object
                 })




