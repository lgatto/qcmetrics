QcMetrics <- setClass("QcMetrics",
         slots = list(qcdata = "list"),
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


setMethod("qcdata", "QcMetrics",
          function(object) object@qcdata)


setMethod("[","QcMetrics",
          function(x, i="numeric", j="missing", drop="missing") {
              x@qcdata <- x@qcdata[i]
              x
        })


setMethod("[[","QcMetrics",
          function(x, i="numeric", j="missing" ,drop="missing") 
          x@qcdata[[i]])

