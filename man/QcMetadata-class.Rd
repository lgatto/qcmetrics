\name{QcMetadata-class}
\Rdversion{1.1}
\docType{class}
\alias{QcMetadata-class}
\alias{QcMetadata}
\alias{metadata,QcMetadata-method}
\alias{mdata,QcMetadata-method}
\alias{show,QcMetadata-method}

\title{The \code{"QcMetadata"} class}

\description{
  The \code{QcMetadata} class is a simple inteface to metadata. 
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
  }
}


\author{
Laurent Gatto <lg390@cam.ac.uk>
}


\examples{
QcMetadata(metadata = list(name = "John Doe"),
           lab = "Big Lab in Big Uni")
}

\keyword{classes}

