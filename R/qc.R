##' A simple wrapper function that uses \code{affy}'s RNA
##' degradation curves and \code{yaqcaffy}'s actin and GAPDH
##' 3'/5' ratios to generate a simple RNA degradation
##' \code{QcMetrics} results. Optionally generates a QC report.
##' See the \code{qcmetrics} vignette for an explanation of the
##' function and an example.
##'
##' @title A simple RNA degradation QC for Affymetric arrays
##' @param input A \code{character} of CEL file names or an
##' instance of class \code{affybatch}. 
##' @param status A \code{logical} of length 2 to set the
##' respective \code{QcMetric}'s statuses.
##' @param type The \code{type} of the report to be generated.
##' Is missing, no report is generated. 
##' @param reportname The name of the report.
##' @return Invisibly return the \code{QcMetrics} for the \code{input}.
##' @seealso \code{\link{QcMetric}} and \code{\link{QcMetrics}} for
##' details about the QC infrastrucutre and \code{\link{qcReport}}
##' for information about the report generation. 
##' @author Laurent Gatto
rnadeg <- function(input, status,
                   type, reportname = "rnadegradation") {
    suppressPackageStartupMessages(library("affy"))
    suppressPackageStartupMessages(library("yaqcaffy"))
    if (is.character(input))
        input <- ReadAffy(input)
    ## first QC item
    qc1 <- QcMetric(name = "Affy RNA degradation slopes")
    qcdata(qc1, "deg") <- AffyRNAdeg(refA)
    plot(qc1) <- function(object) {
        x <- qcdata(object, "deg")
        nms <- x$sample.names
        plotAffyRNAdeg(x, col = 1:length(nms))
        legend("topleft", nms, lty = 1, cex = 0.8, 
               col = 1:length(nms), bty = "n")
    }
    if (!missing(status))
        status(qc1) <- status[1]
    ## second QC item
    qc2 <- QcMetric(name = "Affy RNA degradation ratios")
    qcdata(qc2, "yqc") <- yaqc(refA)
    plot(qc2) <- function(object) {
        par(mfrow = c(1, 2))
        yaqcaffy:::.plotQCRatios(qcdata(object, "yqc"), "all")
    }
    if (!missing(status))
        status(qc2) <- status[2]
    ## bundle into QcMetrics 
    qcm <- QcMetrics(qcdata = list(qc1, qc2))    
    if (!missing(type))    
        qcReport(qcm, reportname, type = type,
                 title = "Affymetrix RNA degradation report")
    invisible(qcm)
}
