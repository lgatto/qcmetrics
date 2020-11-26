example_reports <- function(report = c("protqc",
                                       "n15qc",
                                       "custom",
                                       "rnadeg")) {
    report <- match.arg(report, several.ok = FALSE)
    dir(system.file("reports", package = "qcmetrics"),
        pattern = report, full.names = TRUE)
}
