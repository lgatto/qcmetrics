setMethod("qcReport", "QcMetrics",
          function(object,
                   reportname = "qcreport",
                   type = c("pdf", "tex", "nozzle", "Rmd", "html"),
                   author = Sys.getenv("USER"),
                   title = "Quality control report generated with qcmetrics",
                   summary = TRUE,
                   sessioninfo = TRUE,
                   template = NULL,
                   clean = TRUE,
                   quiet = TRUE,
                   reporter,
                   qcto,
                   ...) {
              if (length(object) == 0) {
                  message("Empty 'QcMetrics' input. No report generated")
                  return(NULL)
              }              
              type <- match.arg(type)
              if (!missing(reporter)) {
                  out <- reporter
              } else {
                  out <- switch(type,
                                Rmd = reporting_rmd(object, reportname,
                                    author, title,
                                    summary, sessioninfo, qcto = Qc2Rmd),
                                html = reporting_html(object, reportname,
                                    author, title,
                                    summary, sessioninfo,
                                    clean, quiet, qcto = Qc2Rmd),
                                tex = reporting_tex(object, reportname,
                                    author, title,
                                    summary, sessioninfo,
                                    template, quiet, qcto = Qc2Tex),
                                pdf = reporting_pdf(object, reportname,
                                    author, title,
                                    summary, sessioninfo,                  
                                    template,
                                    clean, quiet, qcto = Qc2Tex, ...),
                                nozzle = reporting_nozzle(object, reportname))
              }
              message("Report written to ", out)   
              invisible(out)
          })





