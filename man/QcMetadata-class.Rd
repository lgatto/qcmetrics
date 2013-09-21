\name{QcMetadata-class}
\Rdversion{1.1}
\docType{class}
\alias{QcMetadata-class}
\alias{class:QcMetadata}
\alias{QcMetadata}
\alias{metadata,QcMetadata-method}
\alias{mdata,QcMetadata-method}
\alias{show,QcMetadata-method}
\alias{print,QcMetadata-method}
\alias{length,QcMetadata-method}

\title{The \code{"QcMetadata"} class}

\description{
  The \code{QcMetadata} class is a simple inteface to metadata. The
  objects can be displayed with \code{show} for a summary and
  \code{print} for the content.
}


\section{Objects from the Class}{
  Objects can be created by calls of the form \code{QcMetadata(...)}.
}

\section{Slots}{
  \describe{
    \item{\code{metadata}:}{Object of class \code{"list"} that stores
      the metadata variables. }
  }
}

\section{Methods}{
  \describe{
    \item{metadata}{\code{signature(object = "QcMetadata")}: return the
      \code{object}'s metadata list. Also available as \code{mdata}. }
    \item{metadata<-}{\code{signature(object = "QcMetadata", value =
	"list")}: sets the objects metadata. Also available as
      \code{mdata}. }
    \item{length}{\code{signature(x = "QcMetadata")}: returns the number
      of meta-data variables.}
  }
}


\author{
Laurent Gatto <lg390@cam.ac.uk>
}


\examples{
QcMetadata(metadata =
           list(name = "John Doe",
                lab = "Big Lab in Big Uni"))
## less typing
qmd <- QcMetadata(list(name = "John Doe",
                       lab = "Big Lab in Big Uni"))
mdata(qmd)
show(qmd)
print(qmd)
}

\keyword{classes}

