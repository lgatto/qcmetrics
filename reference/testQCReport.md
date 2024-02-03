Quality control report generated with `qcmetrics`
===========================================


Author: 

Date: Sat Feb  3 05:21:40 2024


Metadata
-----------------------------

- **name** Prof. Who
- **lab** Big lab
- **uni** Cabin University


My test QcMetric
-------------------------


```
## Object of class "QcMetric"
##  Name: My test QcMetric 
##  Description:
## This qc metric describes bla bla bla, indicating possible issues in the
## third step of protocol bla bla bla.
##  Status: FALSE 
##  Data: qc1 qc2
```
<div class="figure" style="text-align: left">
<img src="figure/unnamed-chunk-1-1.png" alt="plot of chunk unnamed-chunk-1"  />
<p class="caption">plot of chunk unnamed-chunk-1</p>
</div>
My other metric
-------------------------


```
## Object of class "QcMetric"
##  Name: My other metric 
##  Status: TRUE 
##  Data: k x
```

```
## Loading required package: lattice
```

<div class="figure" style="text-align: left">
<img src="figure/unnamed-chunk-2-1.png" alt="plot of chunk unnamed-chunk-2"  />
<p class="caption">plot of chunk unnamed-chunk-2</p>
</div>
QC summary
-----------------------------

<!-- html table generated in R 4.4.0 by xtable 1.8-4 package -->
<!-- Sat Feb  3 05:21:40 2024 -->
<table border=1>
<tr> <th>  </th> <th> name </th> <th> status </th>  </tr>
  <tr> <td align="right"> 1 </td> <td> My test QcMetric </td> <td> FALSE </td> </tr>
  <tr> <td align="right"> 2 </td> <td> My other metric </td> <td> TRUE </td> </tr>
   </table>

Session information
-------------------------


```
## R Under development (unstable) (2024-01-31 r85845)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 22.04.3 LTS
## 
## Matrix products: default
## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
## LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.20.so;  LAPACK version 3.10.0
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C              
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## time zone: UTC
## tzcode source: system (glibc)
## 
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods  
## [8] base     
## 
## other attached packages:
## [1] lattice_0.22-5      MSnbase_2.29.3      ProtGenerics_1.35.2
## [4] S4Vectors_0.41.3    mzR_2.37.0          Rcpp_1.0.12        
## [7] Biobase_2.63.0      BiocGenerics_0.49.1 qcmetrics_1.41.1   
## 
## loaded via a namespace (and not attached):
##  [1] bitops_1.0-7                rlang_1.1.3                
##  [3] magrittr_2.0.3              clue_0.3-65                
##  [5] matrixStats_1.2.0           compiler_4.4.0             
##  [7] systemfonts_1.0.5           vctrs_0.6.5                
##  [9] pkgconfig_2.0.3             crayon_1.5.2               
## [11] fastmap_1.1.1               XVector_0.43.1             
## [13] pander_0.6.5                utf8_1.2.4                 
## [15] rmarkdown_2.25              preprocessCore_1.65.0      
## [17] ragg_1.2.7                  purrr_1.0.2                
## [19] xfun_0.41                   MultiAssayExperiment_1.29.0
## [21] zlibbioc_1.49.0             cachem_1.0.8               
## [23] GenomeInfoDb_1.39.5         highr_0.10                 
## [25] DelayedArray_0.29.1         BiocParallel_1.37.0        
## [27] parallel_4.4.0              cluster_2.1.6              
## [29] R6_2.5.1                    limma_3.59.1               
## [31] GenomicRanges_1.55.2        iterators_1.0.14           
## [33] SummarizedExperiment_1.33.3 knitr_1.45                 
## [35] IRanges_2.37.1              Matrix_1.6-5               
## [37] igraph_2.0.1.1              tidyselect_1.2.0           
## [39] rstudioapi_0.15.0           abind_1.4-5                
## [41] yaml_2.3.8                  doParallel_1.0.17          
## [43] codetools_0.2-19            affy_1.81.0                
## [45] curl_5.2.0                  tibble_3.2.1               
## [47] plyr_1.8.9                  withr_3.0.0                
## [49] evaluate_0.23               desc_1.4.3                 
## [51] xml2_1.3.6                  pillar_1.9.0               
## [53] affyio_1.73.0               BiocManager_1.30.22        
## [55] MatrixGenerics_1.15.0       whisker_0.4.1              
## [57] foreach_1.5.2               MALDIquant_1.22.2          
## [59] ncdf4_1.22                  generics_0.1.3             
## [61] RCurl_1.98-1.14             ggplot2_3.4.4              
## [63] munsell_0.5.0               scales_1.3.0               
## [65] xtable_1.8-4                glue_1.7.0                 
## [67] lazyeval_0.2.2              tools_4.4.0                
## [69] mzID_1.41.0                 QFeatures_1.13.2           
## [71] vsn_3.71.0                  fs_1.6.3                   
## [73] XML_3.99-0.16.1             grid_4.4.0                 
## [75] impute_1.77.0               MsCoreUtils_1.15.3         
## [77] colorspace_2.1-0            GenomeInfoDbData_1.2.11    
## [79] PSMatch_1.7.1               cli_3.6.2                  
## [81] textshaping_0.3.7           fansi_1.0.6                
## [83] S4Arrays_1.3.3              dplyr_1.1.4                
## [85] downlit_0.4.3               AnnotationFilter_1.27.0    
## [87] pcaMethods_1.95.0           gtable_0.3.4               
## [89] digest_0.6.34               SparseArray_1.3.3          
## [91] htmlwidgets_1.6.4           memoise_2.0.1              
## [93] htmltools_0.5.7             pkgdown_2.0.7.9000         
## [95] lifecycle_1.0.4             httr_1.4.7                 
## [97] statmod_1.5.0               MASS_7.3-60.2
```
