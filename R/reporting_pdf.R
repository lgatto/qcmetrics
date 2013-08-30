## Need a knitr_header
##        knitr_footer

reporting_knitr <- function(object, ...) {
    cat("\\section{", name(object) , "}\n\n", sep = "")
    cat("<<dev='pdf', echo=TRUE>>=\n")
    cat("show(object)\n")
    cat("@\n\n") 
    cat("\\begin{figure}[!hbt]\n")
    cat("<<dev='pdf', echo=TRUE>>=\n")
    cat("plot(object)\n")
    cat("@\n") 
    cat("\\end{figure}\n\n")
    invisible()
}
