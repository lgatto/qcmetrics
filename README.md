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

QC pipelines and packages will be described and disseminated through the [wiki](https://github.com/lgatto/qcmetrics/wiki).

## TODO

#### Reporting 
- [ ] TODO Bioc reportinTools
- [X] TODO Add metadata section
- [ ] TODO allow customisaton of meta-data section
- [ ] TODO Add a `save` arg to qcReport to save `object` and provide link in report.
- [ ] Improve nozzle report
- [ ] Dynamic reports could be created using `shiny`.
- [ ] Also look at arrayQualityMetrics report.
- [X] Report customisation
  - [X] pdf via different template 
  - [X] html via css
- [X] html, pdf
- [X] externalise the report-generating code into functions and 
      add a reporter argument to qcReport to provide custom reporting fuctions.

#### Applications
Illustrate the recipes/usage of `qcmetrics` on different types of data. 
- [X] Short QC pipelines for raw proteomics data
- [X] RNA degradation
- [X] Document the creation of new packages using `qcmetrics`.
- [ ] Add an example for RNASeq, see `ShortReads`
- [ ] QuaMeter idfree quality control

#### Serialisation 
- [X] Objects can of course be serialised with `save`, `saveRDS`.
- [ ] See if it is possible to interface with the `qcML` standard.


