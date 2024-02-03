\name{qcReport-methods}
\docType{methods}
\alias{qcReport-methods}
\alias{qcReport,QcMetrics-method}
\alias{qcReport}
\alias{reporting}
\alias{reporting_pdf}
\alias{reporting_tex}
\alias{reporting_rmd}
\alias{reporting_html}
\alias{example_reports}

\title{ Automatic report generation }

\description{
  The \code{qcReport} method generates report in various formats taking
  a \code{\linkS4class{QcMetrics}} instance as input. Each individual
  quality control item produces a section with description of the item
  and a assessment figure.
}


\details{

  The reporting functions take a \code{QcMetrics} instance as input,
  generate the source of the report and compile it into the final format
  that are currently available are \code{reporting_pdf},
  \code{reporting_tex}, \code{reporting_rmd} and \code{reporting_html}.
  See \code{\link{qcto}} for details about the sectioning functions,
  that convert individual \code{QcMetric} objects into adequate report
  sections.

  The package vignette documents the report generation in more details
  and describes possibilities for customisation.
}

\section{Methods}{
  \describe{
    \item{\code{signature(
        object = "QcMetrics",
        reportname = "character",
        type = "character",
        author = "character",
        title = "character",
        metadata = "logical",
        toc = "logical",
        summary = "logical",
        sessioninfo = "logical",
        clean = "logical",
        quiet = "logical",
        reporter,
        qcto,
        ...)}}{
      generates a report for the \code{\link{QcMetrics}}
      \code{object}. The report will be named according the
      \code{reportname} (default is \code{qcreprt})and \code{type}, the
      latter defining the output format and the extension. Possible
      types are \code{pdf} (default), "tex", "Rmd", "html" (all
      generated using the package \code{knitr}). A custom \code{title}
      can be provided; default is "Quality control report generated with
      qcmetrics". If no \code{author} is provided, the default value
      (\code{Sys.getenv("USER")}) is used. The addition of a table of
      contents (default is \code{FALSE}), a metadata section, a summary
      section and the session information can be controlled with the
      \code{toc}, \code{metadata}, \code{summary} and
      \code{sessioninformation} arguments. The metadata section is
      added to the report when present and the other have \code{TRUE} as
      default.

      Intermediate files are deleted, unless \code{clean} is set to
      \code{FALSE} and verbose output can be turned on by setting
      \code{quiet} to \code{FALSE}.

      The \code{reporter} and \code{qcto} arguments are used to convert
      \code{QcMetric} and \code{QcMetrics} objects into report
      source. See Details and the package vignette for details.

      Addition parameters can be passed to inner functions. For the
      \code{pdf} report, passed to \code{texi2pdf}; for \code{html},
      passed to \code{markdown::markdownToHTML}.

      The method invisibly returns the name of the report that was
      generated.
    }
  }
}

\examples{
example(QcMetrics)
show(qcm)

destdir <- tempdir()
(report <- file.path(destdir, "testQCReport"))


\dontrun{
  ## pdf report
  qcReport(qcm, reportname = report)
  ## use pdflatex to generate the pdf file
  qcReport(qcm, reportname = report, texi2dvi = "pdflatex")
}

## default html report
html <- qcReport(qcm, reportname = report, type = "html")
html
if (interactive())
    browseURL(html)
}

\keyword{methods}
\keyword{report}
