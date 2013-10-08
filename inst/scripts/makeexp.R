library("RforProteomics")
msfile <- getPXD000001mzXML()
library("MSnbase")
exp0 <- readMSData(msfile, verbose = FALSE)

exp <- exp0[seq(1, length(exp0), by = 3)]
save(exp, file = "~/dev/00_github/qcmetrics/inst/extdata/exp.rda",
     compress = "xz", compression_level = 9)

