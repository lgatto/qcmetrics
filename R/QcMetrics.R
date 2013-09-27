QcMetrics <- setClass("QcMetrics",
         slots = list(
             metadata = "QcMetadata",
             qcdata = "list"),
         validity = function(object) {
             msg <- validMsg(NULL, NULL)
             cls <- unique(sapply(object@qcdata, class))             
             if (cls != "QcMetric")
                 msg <- validMsg(msg, "Metrics must all be of class 'QcMetric'.")
             if (is.null(msg)) TRUE
             else msg
         })

setMethod("show", "QcMetrics",
          function(object) {
              cat("Object of class \"", class(object), "\"\n", sep="")
              n <- length(qcdata(object))
              m <- length(mdata(object))
              if (n == 0) n <- "no"
              if (m == 0) m <- "no"                  
              cat(" containing", n, "QC metrics.\n")
              cat(" and", m, "metadata variables.\n")              
          })

setMethod("status", "QcMetrics",
          function(object) sapply(qcdata(object), status))

setReplaceMethod("status", signature(object="QcMetrics", value="logical"),
                 function(object, value) {
                     if (length(object) != length(value))
                         stop("The length of the statuses must be equal to the number of QC items.")
                     l <- qcdata(object)
                     for (i in seq_along(value))
                         status(l[[i]]) <- value[i]
                     qcdata(object) <- l
                     object
                 })

as.data.frame.QcMetrics <-
    function(x, row.names=NULL, optional=FALSE, ...) as(x,"data.frame")    

setMethod("qcdata", "QcMetrics",
          function(object, x = "missing") object@qcdata)

setReplaceMethod("qcdata",
                 signature(object="QcMetrics", value="list"),
                 function(object, value) {
                     object@qcdata <- value
                     object
                 })

setMethod("metadata", "QcMetrics",
          function(object) metadata(object@metadata))

setMethod("mdata", "QcMetrics",
          function(object) metadata(object))

setReplaceMethod("metadata",
                 signature(object="QcMetrics", value="list"),
                 function(object, value) {
                     checkMetaDataListNames(value)
                     oldmd <- object@metadata@metadata
                     oldnms <- names(oldmd)                     
                     newnms <- names(value)
                     l <- unique(c(oldnms, newnms))
                     finalmd <- vector(mode = "list", length = length(l))
                     names(finalmd) <- l
                     finalmd[oldnms] <- oldmd
                     finalmd[newnms] <- value
                     checkMetaDataListNames(finalmd)
                     value <- QcMetadata(metadata = finalmd)                     
                     metadata(object) <- value
                     object
                 })

setReplaceMethod("mdata",
                 signature(object="QcMetrics", value="list"),
                 function(object, value) {
                     metadata(object) <- value
                     object
                 })

setReplaceMethod("metadata",
                 signature(object="QcMetrics", value="QcMetadata"),
                 function(object, value) {
                     object@metadata <- value
                     object
                 })

setReplaceMethod("mdata",
                 signature(object="QcMetrics", value="QcMetadata"),
                 function(object, value) {
                     object@metadata <- value
                     object
                 })

setMethod("[","QcMetrics",
          function(x, i="numeric", j="missing", drop="missing") {
              x@qcdata <- x@qcdata[i]
              x
        })


setMethod("[[","QcMetrics",
          function(x, i="numeric", j="missing" ,drop="missing") 
          x@qcdata[[i]])


setMethod("name", "QcMetrics",
          function(object) sapply(qcdata(object), name))

setMethod("length", "QcMetrics",
          function(x) length(qcdata(x)))

setAs("QcMetrics", "data.frame",
      function (from) {
          data.frame(name = name(from),
                     status = status(from))
      })
