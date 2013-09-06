reporting_knitr_tex<- function(qcm, i) {
    c(paste0("\\section{", name(qcm[[i]]), "}"),
      paste0("<<", name(qcm[[i]]), ", echo=FALSE>>="),
      paste0("show(qcm[[", i, "]])"),
      "@\n",
      "\\begin{figure}[!hbt]",
      "<<dev='pdf', echo=FALSE, fig.width=5, fig.height=5, fig.align='center'>>=",
      paste0("plot(qcm[[", i, "]])"),
      "@",
      "\\end{figure}",
      "\\clearpage")
}

reporting_knitr_rmd<- function(qcm, i) {
    c(paste0("## ", name(qcm[[i]])),
      paste0("```{r ", name(qcm[[i]]), ", echo=FALSE}"),
      paste0("show(qcm[[", i, "]])"),
      "```",
      "```{r, echo=FALSE, fig.width=5, fig.height=5, fig.align='left'}",
      paste0("plot(qcm[[", i, "]])"),
      "```")
}

