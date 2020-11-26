##' A simple wrapper for the QC of 15N labelling. The respective
##' QC items are the distribution of PSM incorporation rates,
##' distribution of log2 fold-changes and number of identified
##' features. See the vignette for details.
##'
##' @title N15 labelling QC report
##' @param object An \code{MSnSet} to be quality controlled.
##' @param fcol The name of the feature variables for the protein
##'     identifiers (accession numbers for example), the peptide
##'     sequences, the number of unique peptides for each identified
##'     protein, the variable modifications identified on the peptides
##'     and the N15 incorporation rate.  These must be provided in
##'     that order. Defaults are \code{Protein_Accession},
##'     \code{Peptide_Sequence}, \code{Number_Of_Unique_Peptides},
##'     \code{Variable_Modifications}, and \code{inc}.
##' @param inctr The minimum level of median incorporation rate to set
##'     the QC item status to \code{TRUE}. Default is 97.5.
##' @param lfctr The range of accepted median PSM log2 fold-change for
##'     the QC item status to be set to \code{TRUE}.  Default is
##'     \code{c(-0.5, 0.5)}.
##' @param type The type of report to be saved. If missing (default),
##'     no report is generated. See \code{\link{qcReport}} for
##'     details.
##' @param reportname The name of the report, in case a \code{type} is
##'     defined. If missing (default), the report will be names
##'     \code{n15qcreport} followed by the generation data and time.
##' @return Invisibly returns the resulting \code{QcMetrics} instance.
##' @author Laurent Gatto
n15qc <- function(object,
                  fcol = c("Protein_Accession",
                      "Peptide_Sequence",
                      "Number_Of_Unique_Peptides",
                      "Variable_Modifications",
                      "inc"),
                  inctr = 97.5,
                  lfctr = c(-0.5, 0.5),
                  type,
                  reportname) {
    stopifnot(requireNamespace("MSnbase"))
    stopifnot(requireNamespace("Biobase"))
    stopifnot(requireNamespace("ggplot2"))
    stopifnot(inherits(object, "MSnSet"))
    stopifnot(all(fcol %in% MSnbase::fvarLabels(object)))
    
    ## incorporation rate QC metric
    qcinc <- QcMetric(name = "15N incorporation rate")
    qcdata(qcinc, "inc") <- MSnbase::fData(object)[, fcol[5]]
    qcdata(qcinc, "tr") <- inctr
    status(qcinc) <- median(qcdata(qcinc, "inc")) > qcdata(qcinc, "tr")

    show(qcinc) <- function(object) {
        qcshow(object, qcdata = FALSE) 
        cat(" QC threshold:", qcdata(object, "tr"), "\n")
        cat(" Incorporation rate\n")
        print(summary(qcdata(object, "inc")))
        invisible(NULL)
    }
    plot(qcinc) <- function(object) {
        inc <- qcdata(object, "inc")
        tr <- qcdata(object, "tr")
        lab <- "Incorporation rate"
        dd <- data.frame(inc = qcdata(qcinc, "inc"))
        p <- ggplot2::ggplot(dd, ggplot2::aes(factor(""), inc)) +            
             ggplot2::geom_jitter(colour = "#4582B370", size = 3) + 
             ggplot2::geom_boxplot(fill = "#FFFFFFD0",
                                   colour = "#000000", outlier.size = 0) +
             ggplot2::geom_hline(yintercept = tr, colour = "red",
                                 linetype = "dotted", size = 1) +
             ggplot2::labs(x = "", y = "Incorporation rate") 
        p
    }

    ## summarise data
    MSnbase::fData(object)$modseq <- ## pep seq + PTM
        paste(MSnbase::fData(object)[, fcol[2]],
              MSnbase::fData(object)[, fcol[4]], sep = "+")
    pep <- MSnbase::combineFeatures(object,
                                    as.character(MSnbase::fData(object)[, fcol[2]]), 
                                    "median", verbose = FALSE)
    modpep <- MSnbase::combineFeatures(object,
                                       MSnbase::fData(object)$modseq,
                                       "median", verbose = FALSE)
    prot <- MSnbase::combineFeatures(object,
                                     as.character(MSnbase::fData(object)[, fcol[1]]), 
                                     "median", verbose = FALSE)

    ## calculate log fold-change
    qclfc <- QcMetric(name = "Log2 fold-changes")
    qcdata(qclfc, "lfc.psm") <-
        log2(MSnbase::exprs(object)[,"unlabelled"] / MSnbase::exprs(object)[, "N15"])
    qcdata(qclfc, "lfc.pep") <-
        log2(MSnbase::exprs(pep)[,"unlabelled"] / MSnbase::exprs(pep)[, "N15"])
    qcdata(qclfc, "lfc.modpep") <-
        log2(MSnbase::exprs(modpep)[,"unlabelled"] / MSnbase::exprs(modpep)[, "N15"])
    qcdata(qclfc, "lfc.prot") <-
        log2(MSnbase::exprs(prot)[,"unlabelled"] / MSnbase::exprs(prot)[, "N15"])
    qcdata(qclfc, "explfc") <- lfctr
    
    status(qclfc) <-
        median(qcdata(qclfc, "lfc.psm")) > qcdata(qclfc, "explfc")[1] &
            median(qcdata(qclfc, "lfc.psm")) < qcdata(qclfc, "explfc")[2]
    
    show(qclfc) <- function(object) {
        qcshow(object, qcdata = FALSE) 
        cat(" QC thresholds:", qcdata(object, "explfc"), "\n")
        cat(" * PSM log2 fold-changes\n")
        print(summary(qcdata(object, "lfc.psm")))
        cat(" * Modified peptide log2 fold-changes\n")
        print(summary(qcdata(object, "lfc.modpep")))
        cat(" * Peptide log2 fold-changes\n")
        print(summary(qcdata(object, "lfc.pep")))
        cat(" * Protein log2 fold-changes\n")
        print(summary(qcdata(object, "lfc.prot")))    
        invisible(NULL)
    }
    plot(qclfc) <- function(object) {
        x <- qcdata(object, "explfc")
        plot(density(qcdata(object, "lfc.psm")),
             main = "", sub = "", col = "red",
             ylab = "", lwd = 2,
             xlab = expression(log[2]~fold-change))    
        lines(density(qcdata(object, "lfc.modpep")),
              col = "steelblue", lwd = 2)
        lines(density(qcdata(object, "lfc.pep")),
              col = "blue", lwd = 2)
        lines(density(qcdata(object, "lfc.prot")),
              col = "orange")
        abline(h = 0, col = "grey")
        abline(v = 0, lty = "dotted")    
        rect(x[1], -1, x[2], 1, col = "#EE000030",
             border = NA)
        abline(v = median(qcdata(object, "lfc.psm")),
               lty = "dashed", col = "blue")
        legend("topright",
               c("PSM", "Peptides", "Modified peptides", "Proteins"),
               col = c("red", "steelblue", "blue", "orange"), lwd = 2,
               bty = "n")
    }
    
    ## number of features
    qcnb <- QcMetric(name = "Number of features")
    qcdata(qcnb, "count") <- c(
        PSM = nrow(object),
        ModPep = nrow(modpep),
        Pep = nrow(pep),
        Prot = nrow(prot))
    qcdata(qcnb, "peptab") <-
        table(MSnbase::fData(object)[, fcol[2]])
    qcdata(qcnb, "modpeptab") <-
        table(MSnbase::fData(object)$modseq)
    qcdata(qcnb, "upep.per.prot") <- 
        MSnbase::fData(object)[, fcol[3]]
    
    show(qcnb) <- function(object) {
        qcshow(object, qcdata = FALSE)
        print(qcdata(object, "count"))
    }
    plot(qcnb) <- function(object) {
        par(mar = c(5, 4, 2, 1))
        layout(matrix(c(1, 2, 1, 3, 1, 4), ncol = 3))
        barplot(qcdata(object, "count"), horiz = TRUE, las = 2)
        barplot(table(qcdata(object, "modpeptab")),
                xlab = "Modified peptides")
        barplot(table(qcdata(object, "peptab")),
                xlab = "Peptides")
        barplot(table(qcdata(object, "upep.per.prot")),
                xlab = "Unique peptides per protein ")
    }

    qcm <- QcMetrics(qcdata = list(qcinc, qclfc, qcnb))    
    metadata(qcm) <- list(File = MSnbase::fileNames(object),
                          Experiment = Biobase::experimentData(object))                          
    if (!missing(type)) {
        if (missing(reportname))
            reportname <- paste("n15qcreport",
                                format(Sys.time(), "%Y-%m-%d-%H:%M:%S"),
                                sep = "_")
        qcReport(qcm, reportname, type = type,                 
                 title = "15N Quality Control")
    }
    invisible(qcm)
}

