setMethod("qcReport", "QcMetrics",
          function(object,
                   outfile = "qcreport.tex",
                   type = c("knitr", "nozzle"),
                   author = Sys.getenv("USER"),
                   title = "Quality control report generated with \\texttt{qcmetrics}",
                   sessioninfo = TRUE,
                   template,
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
              knit(text = unlist(ex), output = outfile)
          })




