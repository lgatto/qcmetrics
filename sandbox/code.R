rm(list = ls(all = TRUE))
library("qcmetrics")

(qc <- QcMetric())
qcdata(qc)
qcdata(qc, "x")

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

(qcm <- QcMetrics(qcdata = list(qc, qc)))
qcdata(qcm)

qcm[1]
qcm[[1]]

