\name{Qc2Tex}
\alias{Qc2Tex}
\alias{Qc2Tex2}
\alias{Qc2Tex3}
\alias{Qc2Rmd}
\alias{qcto}

\title{ 'QcMetric' sectioning functions }

\description{
  These functions convert the \code{i}th \code{QcMetric} instance of the
  \code{QcMetrics} object into a section of the adequate format,
  i.e. TeX of R markdown.
}

\usage{
Qc2Tex(object, i)
Qc2Tex2(object, i)
Qc2Tex3(object, i)
Qc2Rmd(object, i)
}


\arguments{
  \item{object}{An instance of class \code{QcMetrics} with at least one
  QC item. }
  \item{i}{
    A \code{numeric} of length 1 indicating the index of the item to be
    converted into text section. 
  }
}

\value{
  A \code{character} representing the QC item section.
}


\author{
  Laurent Gatto
}

\seealso{
  \code{\link{qcReport}} and the vignette.
}
