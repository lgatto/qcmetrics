reporting_rmd <- function(object,
                          reportname = reportname,
                          author = author,
                          title = title,
                          meta = meta,
                          summary = summary,
                          sessioninfo = sessioninfo,
                          qcto) {
    if (is.null(qcto))
        qcto <- Qc2Rmd
    ext <- "Rmd"
    out <- paste(reportname, ext, sep = ".")
    con <- file(out, "w")
    on.exit(close(con))
    title <- sub("qcmetrics", "`qcmetrics`", title)
    title <- paste0("", title,
                    "\n===========================================\n\n")
    author <- paste0("Author: ", author, "\n")
    .date <- paste0("Date: ", date(), "\n\n")
    writeLines(c(title, author, .date), con)
    for (i in 1:length(object))
        writeLines(qcto(object, i),
                   con)
    if (summary) {
        writeLines("QC summary", con)
        writeLines("-----------------------------\n", con)
        smry <- c("```{r echo=FALSE}",
                  "library('pander')",
                  "pandoc.table(as(object, 'data.frame'))",
                  "```")
        writeLines(smry, con)
    }
    if (sessioninfo) {
        si <- c("Session information",
                "-------------------------\n",
                "```{r echo=FALSE}",
                "sessionInfo()",
                "```")
        writeLines(si, con)
    }
    return(out)
}

reporting_html <- function(object,
                           reportname = reportname,
                           author = author,
                           title = title,
                           meta = meta, 
                           summary = summary,
                           sessioninfo = sessioninfo,
                           template,
                           clean = clean, 
                           quiet = quiet,
                           qcto) {
    if (is.null(qcto))
        qcto <- Qc2Rmd
    ext <- "Rmd"
    out <- paste(reportname, ext, sep = ".")
    con <- file(out, "w")
    title <- sub("qcmetrics", "`qcmetrics`", title)
    title <- paste0("", title,
                    "\n===========================================\n\n")
    author <- paste0("Author: ", author, "\n")
    .date <- paste0("Date: ", date(), "\n\n")
    writeLines(c(title, author, .date), con)
    for (i in 1:length(object))
        writeLines(qcto(object, i),
                   con)
    if (summary) { ## only difference with Rmd type
        writeLines("QC summary", con)
        writeLines("-----------------------------\n", con)
        writeLines(print(xtable(as(object, 'data.frame')),
                         type = 'html',
                         print.results = FALSE),
                   con)
    }
    if (sessioninfo) 
        writeLines(c("Session information",
                     "-------------------------\n",
                     "```{r echo=FALSE}",
                     "sessionInfo()",
                     "```"),
                   con)
    close(con)
    ## procude html    
    ext <- "html"
    if (!is.null(template)) {
        out <- knit2html(out,
                         output = paste(reportname, ext, sep = "."),
                         stylesheet = template, 
                         quiet = quiet)
    } else {
        out <- knit2html(out,
                         output = paste(reportname, ext, sep = "."),
                         quiet = quiet)
    }        
    if (clean) {
        unlink(paste(reportname, "Rmd", sep = "."))
        unlink(paste(reportname, "md", sep = "."))
    }
    return(out)
}

reporting_pdf <- function(object,
                          reportname = reportname,
                          author = author,
                          title = title,
                          meta = meta,
                          summary = summary,
                          sessioninfo = sessioninfo,
                          template = template,
                          clean = clean, 
                          quiet = clean,
                          qcto,
                          ...) {
    if (is.null(qcto))
        qcto <- Qc2Tex
    out <- reporting_tex(object,
                         reportname = reportname,
                         author = author,
                         title = title,
                         meta = meta,
                         summary = summary,
                         sessioninfo = sessioninfo,
                         template = template,
                         quiet = quiet,
                         qcto = qcto)     
    ext <- "pdf"
    tools::texi2pdf(out, quiet = quiet, clean = clean, ...)
    out <- paste(reportname, ext, sep = ".")
    if (clean) {
        file.remove(paste0(reportname, ".tex"))
        unlink("figure", recursive = TRUE)
    }
    moved <- file.rename(paste(basename(reportname), ext, sep = "."), out)
    return(out)
}

reporting_tex <- function(object,
                          reportname = reportname,
                          author = author,
                          title = title,
                          meta = meta,
                          summary = summary,
                          sessioninfo = sessioninfo,
                          template = template,
                          ## clean -  no tex files cleaning 
                          quiet = quiet,
                          qcto) {
    if (is.null(qcto))
        qcto <- Qc2Tex
    ext <- "tex"
    if (is.null(template)) 
        template <- system.file("templates", "knitr-template.Rnw",
                                package = "qcmetrics")
    parent <- c('<<parent, include = FALSE>>=',
                paste0('set_parent("', template , '")'),
                '@')
    title <- sub("qcmetrics", "\\\\texttt{qcmetrics}", title)
    title <- paste0('\\title{', title, '}')
    author <- paste0('\\author{', author, '}')
    mktitle <- "\\maketitle"
    mtd <- c()
    if (meta) mtd <- c(metadata_tex(mdata(object)),
                       "\\newpage")
    ex <- lapply(seq_len(length(object)),
                 function(i) qcto(object, i))
    ex <- append(list(mktitle, parent, mtd), ex)
    if (summary)
        ex <- append(ex, 
                     c("\\clearpage",
                       "\\section{QC summary}",
                       "<<summary, results = 'asis', echo = FALSE>>=",
                       "library('xtable')",
                       "xtable(as(object, 'data.frame'))",
                       "@"))
    if (sessioninfo) 
        ex <- append(ex,
                     list(c("\\section{Session information}",
                            "<<session-info, cache=FALSE, results = 'asis', echo=FALSE>>=",
                            "toLatex(sessionInfo())",
                            "@")))                 
    ## generate tex file
    out <- knit(text = unlist(ex),
                output = paste0(reportname, ".tex"),
                quiet = quiet)
    ## TODO also move figure directory
    return(out)
}


Qc2Rmd <- function(object, i) {
    c(paste0("", name(object[[i]]),
             "\n-------------------------\n"),
      paste0("```{r ", name(object[[i]]), ", echo=FALSE}"),
      paste0("show(object[[", i, "]])"),
      "```",
      "```{r, echo=FALSE, fig.width=5, fig.height=5, fig.align='left'}",
      paste0("plot(object[[", i, "]])"),
      "```")
}

Qc2Tex <- function(object, i) {
    c(paste0("\\section{", name(object[[i]]), "}"),
      paste0("<<", name(object[[i]]), ", echo=FALSE>>="),
      paste0("show(object[[", i, "]])"),
      "@\n",
      "\\begin{figure}[!hbt]",
      "<<dev='pdf', echo=FALSE, fig.width=5, fig.height=5, fig.align='center'>>=",
      paste0("plot(object[[", i, "]])"),
      "@",
      "\\end{figure}",
      "\\clearpage")
}



Qc2Tex2 <- function(object, i) {
    nm <- name(object[[i]])
    if (is.na(status(object[[i]]))) {
        symb <- "$\\Circle$"
    } else if (status(object[[i]])) {
        symb <- "{\\color{green} $\\CIRCLE$}"
    } else {
        symb <- "{\\color{red} $\\CIRCLE$}"
    }
    sec <- paste0("\\section{", nm,
                  "\\hspace{2mm}", symb, "}")    
    cont <- c(paste0("<<", name(object[[i]]), ", echo=FALSE>>="),
              paste0("show(object[[", i, "]])"),
              "@\n",
              "\\begin{figure}[!hbt]",
              "<<dev='pdf', echo=FALSE, fig.width=5, fig.height=5, fig.align='center'>>=",
              paste0("plot(object[[", i, "]])"),
              "@",
              "\\end{figure}",
              "\\clearpage")
    c(sec, cont)
}

Qc2Tex3 <- function(object, i) {
    nm <- name(object[[i]])
    if (is.na(status(object[[i]]))) {
        symb <- "$\\Circle$"
    } else if (status(object[[i]])) {
        symb <- "{\\color{green} $\\smiley$}"
    } else {
        symb <- "{\\color{red} $\\frownie$}"
    }
    sec <- paste0("\\section{", nm,
                  "\\hspace{2mm}", symb, "}")    
    cont <- c(paste0("<<", name(object[[i]]), ", echo=FALSE>>="),
              paste0("show(object[[", i, "]])"),
              "@\n",
              "\\begin{figure}[!hbt]",
              "<<dev='pdf', echo=FALSE, fig.width=5, fig.height=5, fig.align='center'>>=",
              paste0("plot(object[[", i, "]])"),
              "@",
              "\\end{figure}",
              "\\clearpage")
    c(sec, cont)
}


## metadata_rmd <-
##     metadata_html <- function(object) {
##         mdsec <- c("Meta-data",
##                    "-----------------------------\n")
##         n <- length(object)
##         if (is.null(names(object@metadata)))
##             names(object@metadata) <-
##                 paste0("Meta-data ", 1:length(n))        
##         for (i in seq_along(n))
##             mdsec <- c(mdsec,
##                        "names(object@metadata)[i]\n", 
##                        "print(metadata(object)[[i]])")
##         c(mdsec, "\\end{itemize}")
##     }


metadata_tex <-
    metadata_pdf <- function(object) {
        stopifnot(class(object) == "QcMetadata")
        mdsec <- "\\section{Meta-data}\n"
        n <- length(object)
        if (is.null(names(object)))
            names(object) <-
                paste0("Meta-data ", 1:n)
        mdsec <- c(mdsec, "\\begin{description}")
        for (i in seq_len(n)) {            
            if (is.vector(metadata(object)[[i]])) {
                mdsec <- c(mdsec,
                           paste0("\\item[",
                                  names(object)[i], "] ",
                                  paste0(object[[i]], collapse = " ")))
            } else {
                mdsec <- c(mdsec,
                           paste0("\\item[", names(object)[i], "]"),
                           '<<echo=FALSE>>=',
                           paste0("mdata(object)[[", i, "]]"),
                           "@")
            }
        }
        c(mdsec, "\\end{description}")
    }
