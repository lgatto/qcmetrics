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
      metaSec <- newSection("Meta Info")
      for (item in 1:length(capture.output(metadata(object)))) {
        metaDat <- newParagraph(capture.output(metadata(object))[item])
        metaSec <- addTo(metaSec, metaDat)
      }
      
      nozreport <- addTo(nozreport, metaSec)
    }
    
    for (i in 1:length(object))                              
        nozreport <- addTo(nozreport, Qc2Nozzle(object, i, reportname))
    
    if (summary){
      library(xtable)
      table <- xtable(as(object, 'data.frame'))
      QCsummary <- newSection("QC summary")
      QCtable <- newHtml(print(table, type = 'html'))
      QCsummary <- addTo(QCsummary, QCtable)
      #TODO: change it to native table format
      #QCtable <- newTable((as(object, 'data.frame')))
      nozreport <- addTo(nozreport, QCsummary)
    }
    
    if(sessioninfo){
      sessInfoSec <- newSection( "Session Info" )
      for(item in 1:length(capture.output(show(sessionInfo())))){
        sesInfoPar <- newParagraph(capture.output(show(sessionInfo()))[item])
        sessInfoSec <- addTo(sessInfoSec, sesInfoPar)
      }
      nozreport <- addTo(nozreport,
                         sessInfoSec)
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
    ## TODO - replacing the placeholder with the real output of qcm[[i]]
    sec <- newSection(name(qcm[[i]]), class = "results")
    
    for(item in 1:length(capture.output(show(maqcm[[1]])))){
      qcShow <- newParagraph(capture.output(show(maqcm[[1]]))[item])
      sec <- addTo(sec, qcShow)
    }
    
    qcfig <- newFigure(file.path("figure", paste0("qcreport_fig", i, ".png")),
                       fileHighRes = file.path("figure", paste0("qcreport_fig", i, ".pdf")))
    ## section
    sec <- addTo(sec, qcfig )
    return(sec)
}
