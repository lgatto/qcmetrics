setMethod("qcReport", "QcMetrics",
          function(object,
                   reportname = "qcreport",
                   type = c("pdf", "tex", "nozzle", "Rmd", "html"),
                   author = Sys.getenv("USER"),
                   title = "Quality control report generated with qcmetrics",
                   summary = TRUE,
                   sessioninfo = TRUE,
                   template,
                   ## reporter = NULL,
                   clean = TRUE,
                   quiet = TRUE,
                   ...) {
              if (length(object) == 0) {
                  message("Empty 'QcMetrics' input. No report generated")
                  return(NULL)
              }
              type <- match.arg(type)
              qcm <- object
              if (type %in% c("Rmd", "html")) {
                  ext <- "Rmd"
                  out <- paste(reportname, ext, sep = ".")
                  con <- file(out, "w")
                  title <- sub("qcmetrics", "`qcmetrics`", title)
                  title <- paste0("# ", title)
                  author <- paste0("Author: ", author, "\n")
                  .date <- paste0("Date: ", date(), "\n\n")
                  writeLines(c(title, author, .date), con)
                  for (i in 1:length(object))
                      writeLines(reporting_knitr_rmd(object, i),
                                 con)
                  if (summary) {
                      writeLines("## QC summary", con)
                      if (type == "Rmd") {
                          smry <- c(smry,
                                    "```{r echo=FALSE}",
                                    "library('pander')",
                                    "pandoc.table(as(object, 'data.frame'))",
                                    "```")
                          writeLines(smry, con)
                      } else { ## html
                          print(xtable(as(qcm, 'data.frame')), type = 'html',
                                file = con)
                      }
                  }
                  if (sessioninfo) {
                      si <- c("## Session information",
                              "```{r echo=FALSE}",
                              "sessionInfo()",
                              "```")
                      writeLines(si, con)
                  }
                  close(con)
                  if (type == "html") {
                      ext <- "html"
                      out <- knit2html(out,
                                       output = paste(reportname, ext, sep = "."),
                                       quiet = quiet)
                      if (clean) {
                          unlink(paste(reportname, "Rmd", sep = "."))
                          unlink(paste(reportname, "md", sep = "."))
                      }
                  }
              }
              if (type %in% c("tex", "pdf")) {
                  ext <- "tex"
                  if (missing(template)) 
                      template <- system.file("templates", "knitr-template.Rnw",
                                              package = "qcmetrics")
                  parent <- c('<<parent, include = FALSE>>=',
                              paste0('set_parent("', template , '")'),
                              '@')
                  title <- sub("qcmetrics", "\\\\texttt{qcmetrics}", title)
                  title <- paste0('\\title{', title, '}')
                  author <- paste0('\\author{', author, '}')
                  mktitle <- "\\maketitle"
                  ex <- lapply(seq_len(length(object)),
                               function(i) reporting_knitr_tex(object, i))
                  ex <- append(list(mktitle, parent), ex)
                  if (summary)
                      ex <- append(ex, ## summary
                                   c("\\clearpage",
                                     "\\section{QC summary}",
                                     "<<summary, results = 'asis', echo = FALSE>>=",
                                     "library('xtable')",
                                     "xtable(as(object, 'data.frame'))",
                                     "@"))
                  if (sessioninfo) {
                      si <- c("\\section{Session information}",
                              "<<session-info, cache=FALSE, results = 'asis', echo=FALSE>>=",
                              "toLatex(sessionInfo())",
                              "@")                         
                      ex <- append(ex, list(si))
                  }
                  out <- knit(text = unlist(ex),
                              output = paste0(reportname, ".tex"),
                              quiet = quiet)
                  if (type == "pdf") {
                      ext <- "pdf"
                      tools::texi2pdf(out, quiet = quiet, clean = clean, ...)
                      out <- paste(reportname, ext, sep = ".")
                  }
                  moved <- file.rename(paste(basename(reportname), ext, sep = "."), out)
                  if (clean) {
                      file.remove(paste0(reportname, ".tex"))
                      unlink("figure", recursive = TRUE)
                  }
              }
              if (type == "nozzle") {
                  dir.create(reportname)
                  dir.create(file.path(reportname, "figure"))
                  nozreport <- newCustomReport(reportname)
                  for (i in 1:length(object))                              
                      nozreport <- addTo(nozreport,
                                         reporting_nozzle(object, i, reportname))
                  out <- file.path(reportname, "index")
                  writeReport(nozreport, filename = out)
                  out <- paste0(out, ".html")
              }
              message("Report written to ", out)   
              invisible(out)
          })





