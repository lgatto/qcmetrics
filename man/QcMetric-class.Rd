\name{QcMetric-class}
\Rdversion{1.1}
\docType{class}
\alias{class:QcMetric}
\alias{QcMetric-class}
\alias{QcMetric}
\alias{name<-,QcMetric,character-method}
\alias{name,QcMetric-method}
\alias{description<-,QcMetric,character-method}
\alias{description,QcMetric-method}
\alias{plot,QcMetric,missing-method}
\alias{plot<-,QcMetric,function-method}
\alias{plot<-}
\alias{qcenv,QcMetric-method}
\alias{qcenv<-,QcMetric,environment-method}
\alias{qcenv}
\alias{qcenv<-}
\alias{qcdata<-,QcMetric,ANY-method}
\alias{qcdata,QcMetric,character-method}
\alias{qcdata,QcMetric,missing-method}
\alias{qcdata}
\alias{qcdata<-}
\alias{qcshow}
\alias{show,QcMetric-method}
\alias{show<-,QcMetric,function-method}
\alias{show<-}
\alias{status<-,QcMetric,logical-method}
\alias{status,QcMetric-method}
\alias{status}
\alias{status<-}


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
    \item{\code{name}:}{Object of class \code{"character"} of length 1
      naming the \code{object}. }
    \item{\code{description}:}{Object of class \code{"character"} of
      arbitrary length describing the qc metric in more details. }
    \item{\code{qcdata}:}{Object of class \code{"environment"} that
      stores the actual data. }
    \item{\code{plot}:}{Object of class \code{"function"} to graphically
      represent the data and infer quality status. }
    \item{\code{show}:}{Object of class \code{"function"} to print a
      short textual representation of the \code{object}. A reasonable
      default value is provided. }
    \item{\code{status}:}{Object of class \code{"logical"} that
      indicates weather the data passes (\code{TRUE}) or fails
      (\code{FALSE}) the metric or has not yet been evaluated. }
  }
}

\section{Methods}{
  \describe{
    \item{name}{\code{signature(object = "QcMetric")}: retrieves the
      name of the \code{object}. }
    \item{name<-}{\code{signature(object = "QcMetric", value =
        "character")}: set the name of the \code{object}. }
    \item{description}{\code{signature(object = "QcMetric")}: retrieves the
      description of the \code{object}. }
    \item{description<-}{\code{signature(object = "QcMetric", value =
        "character")}: set the description of the \code{object}. }
    \item{status}{\code{signature(object = "QcMetric")}: retrieves the
      status of the \code{object}. }
    \item{status<-}{\code{signature(object = "QcMetric", value =
        "logical")}: sets the status of the \code{object}s. }
    \item{qcdata}{\code{signature(object = "QcMetric", x = "missing")}:
      lists all the data \code{object}s that are associated with the
      \code{object}s. }
    \item{qcdata}{\code{signature(object = "QcMetric", x =
        "character")}: retrieves the variable \code{x} for the
      \code{object}. }
    \item{qcdata<-}{\code{signature(object = "QcMetric", var)}: creates
      or overwrites (with a message) the data variable \code{var} by
      assigning the RHS value. If \code{var} is missing and the RHS
      expression is an environment, then \code{qcdata} is reset with all
      the variables in \code{value}. }
    \item{qcenv}{\code{signature(object = "QcMetric")}: return the
      \code{environment} that stores the QC data. }
    \item{qcenv<-}{\code{signature(object = "QcMetric")}:
      Set all variable in the RHS \code{environment} as \code{qcdata}
      variables. Equivalent to \code{qcdata(object) <- x} where \code{x}
      is an environment. }
    \item{show}{\code{signature(object = "QcMetric")}: shows a textual
      summary of \code{object}. The default \code{show} implementation
      is available as the \code{qcshow{object, qcdata}} function. The
      second argument is a logical (default is \code{TRUE}) that
      specifies whether \code{qcdata(object)} should be displayed. }
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
  Laurent Gatto
}


\seealso{
  The \code{\link{QcMetrics}} class to bundle a set of
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
description(qc) <- "This qc metric describes bla bla bla, indicating possible issues in the third step of protocol bla bla bla."
status(qc) <- FALSE
qc

## or
e <- new.env()
e$qc1 <- rnorm(100)
e$qc2 <- 1:100
qcenv(qc) <- e
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

}

\keyword{classes}
