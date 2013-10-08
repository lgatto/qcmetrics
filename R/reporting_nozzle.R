reporting_nozzle <- function(object,
                             reportname) {
    dir.create(reportname)
    dir.create(file.path(reportname, "figure"))
    nozreport <- newCustomReport(reportname)
    for (i in 1:length(object))                              
        nozreport <- addTo(nozreport,
                           Qc2Nozzle(object, i, reportname))
    out <- file.path(reportname, "index")
    writeReport(nozreport, filename = out)
    out <- paste0(out, ".html")
}


Qc2Nozzle <- function(qcm, i, reportdir) {    
    ## create figure        
    figdir <- file.path(reportdir, "figure")
    figpng <- file.path(figdir, paste0("qcreport_fig", i, ".png"))
    figpdf <- file.path(figdir, paste0("qcreport_fig", i, ".pdf"))
    png(figpng)
    print(plot(qcm[[i]]))
    dev.off()
    pdf(figpdf)
    print(plot(qcm[[i]]))
    dev.off()    
    qcfig <- newFigure(file.path("figure", paste0("qcreport_fig", i, ".png")),
                       fileHighRes = file.path("figure", paste0("qcreport_fig", i, ".pdf")))
    ## section
    sec <- newSection(name(qcm[[i]]), class = "results")
    sec <- addTo(sec, qcfig)
    return(sec)
}
