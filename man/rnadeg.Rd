\name{rnadeg}
\alias{rnadeg}
\title{A simple RNA degradation QC for Affymetrix arrays}
\usage{
  rnadeg(input, status, type,
    reportname = "rnadegradation")
}
\arguments{
  \item{input}{A \code{character} of CEL file names or an
  instance of class \code{affybatch}.}

  \item{status}{A \code{logical} of length 2 to set the
  respective \code{QcMetric}'s statuses.}

  \item{type}{The \code{type} of the report to be
  generated. Is missing, no report is generated.}

  \item{reportname}{The name of the report.}
}
\value{
  Invisibly return the \code{QcMetrics} for the
  \code{input}.
}
\description{
  A simple wrapper function that uses \code{affy}'s RNA
  degradation curves and \code{yaqcaffy}'s actin and GAPDH
  3'/5' ratios to generate a simple RNA degradation
  \code{QcMetrics} results. Optionally generates a QC
  report. See the \code{qcmetrics} vignette for an
  explanation of the function and an example.
}
\author{
  Laurent Gatto
}
\seealso{
  \code{\link{QcMetric}} and \code{\link{QcMetrics}} for
  details about the QC infrastructure and
  \code{\link{qcReport}} for information about the report
  generation.
}

