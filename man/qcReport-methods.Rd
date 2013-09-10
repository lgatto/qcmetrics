\name{qcReport-methods}
\docType{methods}
\alias{qcReport-methods}
\alias{qcReport,QcMetrics-method}
\alias{qcReport}

\title{ Automatic report generation }

\description{
  The \code{qcReport} method generates report in various formats taking
  a \code{\linkS4class{QcMetrics}} instance as input. Each indiviual
  quality control item produces a section with description of the item
  and a assessment figure.  
}


\details{
  Explain how to create custom templates...
}

\section{Methods}{
  \describe{
    \item{\code{signature(
	object = "QcMetrics",
	reportname = "character",
	type = "character",
	author = "character",
	title = "character",
	summary = "logical",
	sessioninfo = "logical",
	template = "character",
	clean = "logical",
	quiet = "logical",
	...)}}{
      generates a report for the \code{\linkS4class{QcMetrics}}
      \code{object}. The report will be named according the
      \code{reportname} (default is \code{qcreprt})and \code{type}, the
      latter defining the output format and the extension. Possible
      types are \code{pdf} (default), "tex", "Rmd", "html" (all
      generated using the package \code{knitr}) and "nozzle" (generated
      using the package \code{Nozzle.R1} package.) A custom \code{title}
      can be provided; default is "Quality control report generated with
      qcmetrics". If no \code{author} is provided, the default value
      (\code{Sys.getenv("USRE")}) is used. The addition of a summary
      section and the session information can be controlled with the
      \code{summary} and \code{sessioninformation} arguments, both
      defaulting to \code{TRUE}. It is possible to supply custom
      templates using the \code{template} arguments. Intermediate files
      are deleted, unless \code{clean} is set to \code{FALSE} and
      verbose output can be turned on by setting \code{quiet} to
      \code{FALSE}. Addition parameters can be passed to generate the
      pdf file through \code{...}.
    }
  }
}

\examples{
example(QcMetrics)
show(qcm)

destdir <- tempdir()
(report <- file.path(destdir, "testQCReport"))

## pdf report
qcReport(qcm, reportname = report)

\dontrun{
    ## use pdflatex to generate the pdf file
    qcReport(qcm, reportname = report, texi2dvi = "pdflatex")
}
## html report
html <- qcReport(qcm, reportname = report, type = "html")
html
browseURL(html)
}

\keyword{methods}
