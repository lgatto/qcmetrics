\name{QcMetadata-class}
\Rdversion{1.1}
\docType{class}
\alias{QcMetadata-class}
\alias{class:QcMetadata}
\alias{QcMetadata}
\alias{metadata,QcMetadata-method}
\alias{metadata<-,QcMetadata,list-method}
\alias{mdata<-,QcMetadata,list-method}
\alias{mdata,QcMetadata-method}
\alias{show,QcMetadata-method}
\alias{print,QcMetadata-method}
\alias{length,QcMetadata-method}
\alias{[,QcMetadata-method}
\alias{[[,QcMetadata-method}
\alias{names,QcMetadata-method}
\alias{names<-,QcMetadata,character-method}

\title{The \code{"QcMetadata"} class}

\description{
  The \code{QcMetadata} class is a simple interface to metadata. The
  objects can be displayed with \code{show} for a summary and
  \code{print} for the content.
}


\section{Objects from the Class}{
  Objects can be created by calls of the form \code{QcMetadata(...)}.
}

\section{Slots}{
  \describe{
    \item{\code{metadata}:}{Object of class \code{"list"} that stores
      the metadata variables. The list must be named. \code{NA} and
      empty characters are not allowed. }
  }
}

\section{Methods}{
  \describe{
    \item{[}{\code{signature(x = "QcMetadata")}: subsets \code{x} as a
      new \code{QcMetadata} instance. }
    \item{[[}{\code{signature(x = "QcMetadata")}: extracts a single
      element of \code{x}. }
    \item{metadata}{\code{signature(object = "QcMetadata")}: return the
      \code{object}'s metadata list. Also available as \code{mdata}. }
    \item{metadata<-}{\code{signature(object = "QcMetadata", value =
	"list")}: sets the objects metadata. Also available as
      \code{mdata}. }
    \item{length}{\code{signature(x = "QcMetadata")}: returns the number
      of metadata variables.}
    \item{names}{\code{signature(x = "QcMetadata")}: returns the names
      of the metadata variables. }    
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

