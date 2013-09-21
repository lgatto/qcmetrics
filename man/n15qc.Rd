\name{n15qc}
\alias{n15qc}
\title{N15 labelling QC report}
\usage{
  n15qc(object,
    fcol = c("Protein_Accession", "Peptide_Sequence", "Number_Of_Unique_Peptides", "Variable_Modifications", "inc"),
    inctr = 97.5, lfctr = c(-0.5, 0.5), type, reportname)
}
\arguments{
  \item{object}{An \code{MSnSet} to be QC'ed}

  \item{fcol}{The name of the feature variables for the
  protein identifiers (accession numbers for example), the
  peptide sequences, the number of unique peptides for each
  identified protein, the variable modifications identified
  on the peptides and the N15 incorporation rate. These
  must be profided in that order. Defaults are
  \code{Protein_Accession}, \code{Peptide_Sequence},
  \code{Number_Of_Unique_Peptides},
  \code{Variable_Modifications}, and \code{inc}.}

  \item{inctr}{The minimum level of tolerated median
  incorporation rate to set the QC item status to
  \code{TRUE}. Default is 97.5.}

  \item{lfctr}{The range of accepted median PSM log2
  fold-change for the QC item status to be set to
  \code{TRUE}. Default is \code{c(-0.5, 0.5)}.}

  \item{type}{The type of report to be saved. If missing
  (default), no report is generated. See
  \code{\link{qcReport}} for details.}

  \item{reportname}{The name of the report, in case a
  \code{type} is defined. If missing (default), the report
  will be names \code{n15qcreport) followed by the
  generation data and time.}
}
\value{
  Invisibly returns the resulting \code{QcMetrics}
  instance.
}
\description{
  A simple wrapper for the QC of 15N labelling. The
  repective QC items are the distribution of PSM
  incorporation rates, distribution of log2 fold-changes
  and number of identified features. See the vignette for
  details.
}
\author{
  Laurent Gatto
}

