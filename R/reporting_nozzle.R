reporting_nozzle <- function(object,
                             reportname = reportname,
                             author = author,
                             title = title,
                             meta = meta,
                             summary = summary,
                             sessioninfo = sessioninfo) {
    dir.create(reportname)
    dir.create(file.path(reportname, "figure"))
    
    nozreport <- newCustomReport(reportname)
    nozreport <- setReportSubTitle(nozreport, paste0("Date: ", date()))
    if (author != "") nozreport <- setMaintainerName(nozreport, author)
    
    if (meta) {
      metaSection <- newSection("Meta Info")
      metaDataFrame <- as.data.frame(metadata(object))
      rownames(metaDataFrame) <- NULL
      metaTable <- xtable(metaDataFrame)
      metaHTML <- newHtml(print(metaTable, type = 'html', include.rownames = FALSE))
      metaSection <- addTo(metaSection, metaHTML)
      
      ## alternative routine without xtable output
      # metaSection <- newSection("Meta Info")
      # for (item in 1:length(capture.output(metadata(object)))) {
      #   metaDat <- newParagraph(capture.output(metadata(object))[item])
      #   metaSection <- addTo(metaSection, metaDat)
      # }
      
      nozreport <- addTo(nozreport, metaSection)
    }
    
    for (i in 1:length(object))                              
        nozreport <- addTo(nozreport, Qc2Nozzle(object, i, reportname))
    
    if (summary) {
      sumTable <- xtable(as(object, 'data.frame'))
      sumSection <- newSection("QC summary")
      sumHTML <- newHtml(print(sumTable, type = 'html'))
      sumSection <- addTo(sumSection, sumHTML)
      nozreport <- addTo(nozreport, sumSection)
    }
    
    if (sessioninfo) {
      infoSection <- newSection( "Session Info" )
      for (item in 1:length(capture.output(show(sessionInfo())))) {
        infoParagraph <- newParagraph(capture.output(show(sessionInfo()))[item])
        if (capture.output(show(sessionInfo()))[item] == "") infoParagraph <- newParagraph('>') 
        infoSection <- addTo(infoSection, infoParagraph) 
      }
      nozreport <- addTo(nozreport, infoSection)
    }
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
    sec <- newSection(name(qcm[[i]]), class = "results")
    
    for (item in 1:length(capture.output(show(maqcm[[i]])))) {
      qcShow <- newParagraph(capture.output(show(maqcm[[i]]))[item])
      sec <- addTo(sec, qcShow)
    }
    
    qcfig <- newFigure(file.path("figure", paste0("qcreport_fig", i, ".png")),
                       fileHighRes = file.path("figure", paste0("qcreport_fig", i, ".pdf")))
    ## section
    sec <- addTo(sec, qcfig )
    return(sec)
}
