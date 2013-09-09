QcMetrics <- setClass("QcMetrics",
         slots = list(
             metadata = "list",
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
              n <- length(object@qcdata)
              cat(" containing", n ,
                  ifelse(n == 1,
                         "QC metric.\n",
                         "QC metrics.\n"))
          })

## FIXME: returns a list in case of NULL
setMethod("status", "QcMetrics",
          function(object) sapply(qcdata(object), status))

## FIXME: breaks in case of NULL statuses
as.data.frame.QcMetrics <-
    function(x, row.names=NULL, optional=FALSE, ...) as(x,"data.frame")    

setMethod("qcdata", "QcMetrics",
          function(object, x = "missing") object@qcdata)

setMethod("metadata", "QcMetrics",
          function(object) object@metadata)

setReplaceMethod("metadata",
                 signature(object="QcMetrics", value="list"),
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
