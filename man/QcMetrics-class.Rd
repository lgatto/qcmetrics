\name{QcMetrics-class}
\Rdversion{1.1}
\docType{class}
\alias{QcMetrics-class}
\alias{[,QcMetrics-method}
\alias{[[,QcMetrics-method}
\alias{length,QcMetrics-method}
\alias{metadata,QcMetrics-method}
\alias{metadata<-,QcMetrics,list-method}
\alias{name,QcMetrics-method}
\alias{qcdata,QcMetrics,ANY-method}
\alias{show,QcMetrics-method}
\alias{status,QcMetrics-method}
\alias{as.data.frame.QcMetrics}
\alias{QcMetrics}

\title{Class \code{"QcMetrics"}}

\description{
  Data structure for storing lists of \code{\linkS4class{"QcMetric"}}
  items. 
}

\section{Objects from the Class}{
  Objects can be created using the constructor \code{QcMetrics(...)}, where
  slots are assigned individually. See example below.

  In a standardised quality control pipeline, the \code{QcMetrics} and
  \code{QcMetric} object are not generated manually. Their creation is
  delegated to a wrapper function that reads a specific type of files,
  parses the data, produces the individual \code{QcMetric} instances
  and, eventually, the \code{QcMetric} object. See the package vignette
  for details and examples.
}

\section{Slots}{
  \describe{
    \item{\code{metadata}:}{Object of class \code{"list"} storing the
      metadata of the \code{object}. This list would typically contain
      the input file the data was read from, the date the object was
      generated, ... or fully fledged \emph{minimum information}
      descriptions (see \code{\linkS4class{MIAxE}}), when available. }    
    \item{\code{qcdata}:}{Object of class \code{"list"} storing all the
      indivisual \code{\linkS4class{QcMetric}} instances. }
  }
}
\section{Methods}{
  \describe{
    \item{[}{\code{signature(x = "QcMetrics")}: subsets \code{x} as a
      new \code{QcMetrics} instance. }
    \item{[[}{\code{signature(x = "QcMetrics")}: extracts a single
      \code{\linkS4class{QcMetric}} instance.  }
    \item{length}{\code{signature(x = "QcMetrics")}: returns the number
      of \code{\linkS4class{QcMetric}} instances populate \code{x}.}
    \item{metadata}{\code{signature(object = "QcMetrics")}: return the
      \code{object}'s metadata list. }
    \item{metadata<-}{\code{signature(object = "QcMetric", value =
	"list")}: sets the objects metadata. }
    \item{name}{\code{signature(object = "QcMetrics")}: returns a
      \code{character} vector of length \code{length(object)} with the names
      of the \code{QcMetric} instances. }
    \item{qcdata}{\code{signature(object = "QcMetrics", x = "missing")}:
      returns a list of all \code{\linkS4class{QcMetric}} instances. }
    \item{show}{\code{signature(object = "QcMetrics")}: prints a short
      textual description of \code{object}. }
    \item{status}{\code{signature(object = "QcMetrics")}: returns a
      vector of XXX }
    \item{as}{\code{signature(object = "QcMetrics", "data.frame")}:
      coerces \code{object} as a \code{length(object)} by 2 data frame
      with the respective \code{QcMetric} instances names and statuses. } 
    \item{qcReport}{\code{signature(object = "QcMetrics")}: ... }
  }
}

\author{
  Laurent Gatto <lg390@cam.ac.uk>
}


\seealso{
  The \code{\linkS4class{"QcMetric"}} class for individual QC items.
}

\examples{
example(QcMetric)
show(qc)

qc2 <- QcMetric(name = "My other metric", status = TRUE)
qcdata(qc2, "x") <- rnorm(100)
qcdata(qc2, "k") <- rep(LETTERS[1:2], 50)

plot(qc2) <- function(object, ...) {
    require("lattice")
    d <- data.frame(x = qcdata(object, "x"),
                    k = qcdata(object, "k"))
    bwplot(x ~ k, data = d)
}

qcm <- QcMetrics(qcdata = list(qc, qc2))
qcm

qcm[1] ## a QcMetrics instance
qcm[[1]] ## a single QcMetric

}
\keyword{classes}
