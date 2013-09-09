\name{QcMetrics-class}
\Rdversion{1.1}
\docType{class}
\alias{QcMetrics-class}
\alias{[,QcMetrics-method}
\alias{[[,QcMetrics-method}
\alias{length,QcMetrics-method}
\alias{metadata,QcMetrics-method}
\alias{name,QcMetrics-method}
\alias{qcdata,QcMetrics,ANY-method}
\alias{qcReport,QcMetrics-method}
\alias{show,QcMetrics-method}
\alias{status,QcMetrics-method}

\title{Class \code{"QcMetrics"}}
\description{
%%  ~~ A concise (1-5 lines) description of what the class is. ~~
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("QcMetrics", ...)}.
%%  ~~ describe objects here ~~ 
}
\section{Slots}{
  \describe{
    \item{\code{metadata}:}{Object of class \code{"list"} ~~ }
    \item{\code{qcdata}:}{Object of class \code{"list"} ~~ }
  }
}
\section{Methods}{
  \describe{
    \item{[}{\code{signature(x = "QcMetrics")}: ... }
    \item{[[}{\code{signature(x = "QcMetrics")}: ... }
    \item{length}{\code{signature(x = "QcMetrics")}: ... }
    \item{metadata}{\code{signature(object = "QcMetrics")}: ... }
    \item{name}{\code{signature(object = "QcMetrics")}: ... }
    \item{qcdata}{\code{signature(object = "QcMetrics", x = "ANY")}: ... }
    \item{qcReport}{\code{signature(object = "QcMetrics")}: ... }
    \item{show}{\code{signature(object = "QcMetrics")}: ... }
    \item{status}{\code{signature(object = "QcMetrics")}: ... }
	 }
}

\author{
  Laurent Gatto <lg390@cam.ac.uk>
}


\seealso{
  The \code{\linkS4class{"QcMetric"}} class for individual QC items.
}
\examples{
showClass("QcMetrics")
}
\keyword{classes}
