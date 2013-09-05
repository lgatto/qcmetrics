setMethod("qcReport", "QcMetrics",
          function(object,
                   reportname = "qcreport",
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
                         title <- paste0('\\title{', title, '}')
                         author <- paste0('\\author{', author, '}')
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
                             out <- knit(text = unlist(ex), output = paste0(reportname, ".tex"), quiet = quiet)
                             tools::texi2pdf(out, quiet = quiet, clean = clean, ...)
                             out <- paste0(reportname, ".pdf")
                             moved <- file.rename(paste0(basename(reportname), ".pdf"), out)
                             if (clean) {
                                 file.remove(paste0(reportname, ".tex"))
                                 unlink("figure", recursive = TRUE)
                             }
                             message("Report written to ", out, ".")   
                         }
                     }, nozzle = {
                         stop("Not yet implemeted")
                     })
              invisible(out)
          })




