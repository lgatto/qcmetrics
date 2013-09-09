\name{QcMetric-class}
\Rdversion{1.1}
\docType{class}
\alias{QcMetric-class}
\alias{metadata<-,QcMetric,list-method}
\alias{name<-,QcMetric,character-method}
\alias{name,QcMetric-method}
\alias{plot,QcMetric,missing-method}
\alias{plot<-,QcMetric,function-method}
\alias{qcdata<-,QcMetric-method}
\alias{qcdata,QcMetric,character-method}
\alias{qcdata,QcMetric,missing-method}
\alias{show,QcMetric-method}
\alias{show<-,QcMetric,function-method}
\alias{status<-,QcMetric,LogicalOrNULL-method}
\alias{status,QcMetric-method}

\title{Class \code{"QcMetric"}}

\description{
  Data structure for individual QC metrics items. 
}

\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("QcMetric", ...)}.
}
\section{Slots}{
  \describe{
    \item{\code{name}:}{Object of class \code{"character"} ~~ }
    \item{\code{qcdata}:}{Object of class \code{"environment"} ~~ }
    \item{\code{plot}:}{Object of class \code{"function"} ~~ }
    \item{\code{show}:}{Object of class \code{"function"} ~~ }
    \item{\code{status}:}{Object of class \code{"LogicalOrNULL"} ~~ }
  }
}
\section{Methods}{
  \describe{
    \item{metadata<-}{\code{signature(object = "QcMetric", value = "list")}: ... }
    \item{name<-}{\code{signature(object = "QcMetric", value = "character")}: ... }
    \item{name}{\code{signature(object = "QcMetric")}: ... }
    \item{plot}{\code{signature(x = "QcMetric", y = "missing")}: ... }
    \item{plot<-}{\code{signature(object = "QcMetric", value = "function")}: ... }
    \item{qcdata<-}{\code{signature(object = "QcMetric")}: ... }
    \item{qcdata}{\code{signature(object = "QcMetric", x = "character")}: ... }
    \item{qcdata}{\code{signature(object = "QcMetric", x = "missing")}: ... }
    \item{show}{\code{signature(object = "QcMetric")}: ... }
    \item{show<-}{\code{signature(object = "QcMetric", value = "function")}: ... }
    \item{status<-}{\code{signature(object = "QcMetric", value = "LogicalOrNULL")}: ... }
    \item{status}{\code{signature(object = "QcMetric")}: ... }
	 }
}

\author{
  Laurent Gatto <lg390@cam.ac.uk>
}


\seealso{
  The \code{\linkS4class{"QcMetrics"}} class to bundle a set of
  \code{QcMetric} instances. 
}
\examples{
(qc <- QcMetric())
qcdata(qc)
try(qcdata(qc, "x"))

x <- rnorm(100)
qcdata(qc, "qc1") <- x
qcdata(qc, "qc2") <- 1:100
qcdata(qc)
all.equal(qcdata(qc, "qc1"), x)
all.equal(qcdata(qc, "qc2"), 1:100)
name(qc) <- "My test QcMetric"
status(qc) <- FALSE
qc

show(qc)
show(qc) <- function(object) cat("Updated show method\n")
show(qc)
show(qc) <- qcshow
qc


plot(qc)
plot(qc) <-
    function(object, ...) 
        plot(qcdata(object, "qc2"),
             qcdata(object, "qc1"),
             xlab = "qc1",
             ylab = "qc2",
             ...)
plot(qc)
plot(qc, col = "red", pch = 19)
dev.off()
}

\keyword{classes}
