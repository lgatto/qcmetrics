\name{QcMetric-class}
\Rdversion{1.1}
\docType{class}
\alias{QcMetric-class}
\alias{name<-,QcMetric,character-method}
\alias{name,QcMetric-method}
\alias{plot,QcMetric,missing-method}
\alias{plot<-,QcMetric,function-method}
\alias{qcdata<-,QcMetric-method}
\alias{qcdata,QcMetric,character-method}
\alias{qcdata,QcMetric,missing-method}
\alias{qcshow}
\alias{show,QcMetric-method}
\alias{show<-,QcMetric,function-method}
\alias{status<-,QcMetric,LogicalOrNULL-method}
\alias{status,QcMetric-method}
\alias{QcMetric}


\title{The \code{"QcMetric"} class for QC items}

\description{
  Data structure for individual QC metrics items. 
}

\section{Objects from the Class}{
  Objects can be created using the constructor \code{QcMetric(...)}, where
  slots are assigned individually. See example below.
}
\section{Slots}{
  \describe{
    \item{\code{name}:}{Object of class \code{"character"} describing
      the \code{object}. }
    \item{\code{qcdata}:}{Object of class \code{"environment"} that
      stores the actual data. }
    \item{\code{plot}:}{Object of class \code{"function"} to graphically
      represent the data and infer quality status. }
    \item{\code{show}:}{Object of class \code{"function"} to print a
      short textual representation of the \code{object}. A reasonable
      default value is provided. }
    \item{\code{status}:}{Object of class \code{"LogicalOrNULL"}, i.e
      either a \code{logical} or \code{NULL} that represent the weather
      the data passes (\code{TRUE}) or fails (\code{FALSE}) the metric
      or has not yet been evaluated.}
  }
}

\section{Methods}{
  \describe{
    \item{name}{\code{signature(object = "QcMetric")}: retrieves the
      description of the \code{object}. }	
    \item{name<-}{\code{signature(object = "QcMetric", value =
	"character")}: set the description of the \code{object}. }
    \item{status}{\code{signature(object = "QcMetric")}: retrieves the
      status of the \code{object}. }
    \item{status<-}{\code{signature(object = "QcMetric", value =
	"LogicalOrNULL")}: sets the status of the \code{object}s. }    
    \item{qcdata}{\code{signature(object = "QcMetric", x = "missing")}:
      lists all the data \code{object}s that are associated with the
      \code{object}s. }  
    \item{qcdata}{\code{signature(object = "QcMetric", x =
	"character")}: retrieves the variable \code{x} for the
      \code{object}. }
    \item{qcdata<-}{\code{signature(object = "QcMetric", var)}: creates
      or overwrites (with a message) the data variable \code{var} by
      assigning the RHS value. If \code{var} is missing and the RHS
      expression is an environment, the all the variables associated
      \code{object} are replaces with those in the \code{value}
      environment. } 
    \item{show}{\code{signature(object = "QcMetric")}: shows a textual
      summary of \code{object}. The default \code{show} implementation
      is available as the \code{qcshow} function. }
    \item{show<-}{\code{signature(object = "QcMetric", value =
	"function")}: sets a custom \code{show} method for
      \code{object}. } 
    \item{plot}{\code{signature(x = "QcMetric", y = "missing")}: plots
      the \code{object} using the provide \code{show} method. }
    \item{plot<-}{\code{signature(object = "QcMetric", value =
	"function")}: sets a custom \code{plot} method for
      \code{object}. }
    \item{qcReport}{\code{signature(x = "QcMetric", ...)}: to generate 
      quality reports. See \code{\link{qcReport}} for details. }    
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

x <- rnorm(10)
qcdata(qc, "qc1") <- x
qcdata(qc, "qc2") <- 1:10
qcdata(qc)
all.equal(qcdata(qc, "qc1"), x)
all.equal(qcdata(qc, "qc2"), 1:10)
name(qc) <- "My test QcMetric"
status(qc) <- FALSE
qc

## or
e <- new.env()
e$qc1 <- rnorm(100)
e$qc2 <- 1:100
qcdata(qc) <- e
length(qcdata(qc, "qc1"))
head(qcdata(qc, "qc2"))

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

\dontrun{
    ## generate a report 
    qcReport(qcm)
}
}

\keyword{classes}
