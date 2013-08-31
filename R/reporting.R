setMethod("qcReport", "QcMetric",
          function(object, type = c("knitr", "nozzle", ...) {
              type <- match.call(type)
              case(type,
                   knitr = reporting_knitr(object, ...),
                   nozzle = reporting_nozzle(object, ...))
              invisible()
          })

## Sys.getenv("USER")          
