setMethod("qcReport", "QcMetrics",
          function(object,
                   reportname = "qcreport",
                   type = c("pdf", "tex", "nozzle", "Rmd", "html"),
                   author = Sys.getenv("USER"),
                   title = "Quality control report generated with qcmetrics",
                   meta = length(mdata(object)) > 0,
                   toc = FALSE,
                   summary = TRUE,
                   sessioninfo = TRUE,
                   template = NULL,
                   clean = TRUE,
                   quiet = TRUE,
                   reporter,
                   qcto = NULL,
                   ...) {
              if (length(object) == 0) {
                  message("Empty 'QcMetrics' input. No report generated")
                  return(NULL)
              }
              type <- match.arg(type)
              if (!missing(reporter)) {
                  out <- reporter
              } else {
                  ## dump all current knitr settings and restore them afterwards
                  opts <-
                      c("knit_hooks", "opts_chunk", "opts_hooks", "opts_knit")
                  vals <-
                      sapply(opts, function (name)
                          .subset2(get(name), "get")())
                  on.exit(mapply(
                      function(name, vals)
                          .subset2(get(name), "restore")(vals),
                      opts,
                      vals,
                      SIMPLIFY = FALSE,
                      USE.NAMES = FALSE
                  ),
                  add = TRUE)
                  
                  ## reset to knitr defaults
                  lapply(opts, function(name)
                      .subset2(get(name), "restore")())
                
                  out <- switch(type,
                                Rmd = reporting_rmd(object, reportname,
                                    author, title, meta,
                                    summary, sessioninfo,
                                    qcto),
                                html = reporting_html(object, reportname,
                                    author, title, meta,
                                    summary, sessioninfo,
                                    template, clean, quiet, qcto),
                                tex = reporting_tex(object, reportname,
                                    author, title, meta,
                                    toc, summary, sessioninfo,
                                    template, quiet, qcto),
                                pdf = reporting_pdf(object, reportname,
                                    author, title, meta,
                                    toc, summary, sessioninfo,                  
                                    template,
                                    clean, quiet, qcto, ...),
                                nozzle = reporting_nozzle(object, reportname))
              }
              message("Report written to ", out)   
              invisible(out)
          })

