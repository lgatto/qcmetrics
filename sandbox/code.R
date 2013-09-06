rm(list = ls(all = TRUE))
library("qcmetrics")


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

qc2 <- QcMetric(name = "My other metric", status = TRUE)
qcdata(qc2, "x") <- rnorm(100)
qcdata(qc2, "k") <- rep(LETTERS[1:2], 50)

plot(qc2) <- function(object, ...) {
    require("lattice")
    d <- data.frame(x = qcdata(object, "x"),
                    k = qcdata(object, "k"))
    bwplot(x ~ k, data = d)
}
plot(qc2)
dev.off()

(xx <- QcMetrics(qcdata = list(qc, qc2)))



qcReport(xx, texi2dvi = "pdflatex", author = "Laurent Gatto")
##qcReport(qcm, reportname = "/home/lgatto/REPORT")

qcReport(xx, type = "html")

qcReport(xx, type = "nozzle")
