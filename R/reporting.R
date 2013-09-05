setMethod("qcReport", "QcMetrics",
          function(object,
                   name = "qcreport",
                   type = c("knitr", "nozzle"),
                   author = Sys.getenv("USER"),
                   title = "Quality control report generated with \\texttt{qcmetrics}",
                   sessioninfo = TRUE,
                   template,
                   clean = TRUE,
                   quiet = TRUE,
                   ...) {
              type <- match.arg(type)
              switch(type,
                     knitr = {
                         if (missing(template)) 
                             template <- system.file("templates", "knitr-template.Rnw",
                                                     package = "qcmetrics")
                         parent <- c('<<parent, include = FALSE>>=',
                                     paste0('set_parent("', template , '")'),
                                     '@')
                         mktitle <- "\\maketitle"
                         ex <- lapply(seq_len(length(qcm)),
                                      function(i) reporting_knitr(qcm, i))
                         ex <- append(list(mktitle, parent), ex)
                         if (sessioninfo) {
                             si <- c("\\clearpage",
                                     "\\section{Session information}",
                                     "<<session-info, cache=FALSE, results = 'asis', echo=FALSE>>=",
                                     "toLatex(sessionInfo())",
                                     "@")                         
                             ex <- append(ex, list(si))
                         }
                     }, nozzle = {
                         stop("Not yet implemeted")
                     })
              out <- knit(text = unlist(ex), output = paste0(name, ".tex"), quiet = quiet)
              tools::texi2pdf(basename(out), quiet = quiet, clean = clean, ...)
              out <- knitr:::sub_ext(out, "pdf")
              message("Report written to ", out, ".")
          })




