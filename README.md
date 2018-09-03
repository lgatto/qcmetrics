[![Build Status](https://travis-ci.org/lgatto/qcmetrics.svg?branch=master)](https://travis-ci.org/lgatto/qcmetrics)
[![codecov](https://codecov.io/gh/lgatto/qcmetrics/branch/master/graph/badge.svg)](https://codecov.io/gh/lgatto/qcmetrics)

# A General Framework for Quality Control Metrics



## About 

The `qcmetrics` package provides a general framework to develope
quality control (QC) pipelines for any type of data that can be
imported into `R`. The application of `qcmetrics` can be schematised
in 5 points

1. Identify a set of quality metrics of interest and implement them
   and their visualisation method into individual `QcMetric`
   instances.
2. Bundles the `QcMetric` items into a `QcMetrics` instance. 
3. Automatically generate reports in pdf of html using the `qcReport`
   function using the `QcMetrics` object of step 2 as input.
4. Optionally, reports can be customised. 
5. Wrap the above steps into a wrapper function or a new QC package
   for production use.

QC pipelines and packages will be described and disseminated through
the [wiki](https://github.com/lgatto/qcmetrics/wiki).

## Installation

*[qcmetrics](http://bioconductor.org/packages/qcmetrics)* is a Bioconductor package and should in
installed with


```r
<<<<<<< HEAD
## try http:// if https:// URLs are not supported
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("qcmetrics")
=======
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("qcmetrics")
```

If you prefer to install the development version (not recommended)


```r
BiocManager::install("qcmetrics", version = "devel")
>>>>>>> master
```

## Bugs and question

Either file a
[GitHub issue](https://github.com/lgatto/qcmetrics/issues) or use the
[Bioconductor support forum](https://support.bioconductor.org/).
