# metadata_text was copied from reporting_knitR
# TODO: change it to metadata_nozzle 
metadata_tex <- function(object) {
  stopifnot(class(object) == "QcMetadata")
  mdsec <- "\\section{Metadata}\n"
  n <- length(object)
  if (is.null(names(object)))
    names(object) <-
    paste0("Metadata ", 1:n)
  mdsec <- c(mdsec, "\\begin{description}")
  for (i in seq_len(n)) {            
    if (is.vector(metadata(object)[[i]])) {
      mdsec <- c(mdsec,
                 paste0("\\item[",
                        names(object)[i], "] ",
                        paste0(object[[i]], collapse = " ")))
    } else {
      mdsec <- c(mdsec,
                 paste0("\\item[", names(object)[i], "]\\"),
                 '<<echo=FALSE>>=',
                 paste0("mdata(object)[[", i, "]]"),
                 "@")
    }
  }
  c(mdsec, "\\end{description}")
}

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
      ## TODO: replace latex format with native nozzle format
      metaSec <- newSection("Meta Info")
      metaDat <- newParagraph(metadata_rmd(object@metadata))
      metaSec <- addTo(metaSec, metaDat)
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
      # html conversion yet incomplete 
      PreHTML <- toLatex(sessionInfo(), locale = FALSE)
      generateHTML <- gsub("item", "<br><br>", PreHTML) 
      sesInfoPar <- newHtml(generateHTML)
      #alternative session info generation:
      #sesInfoPar <- newParagraph(toLatex(sessionInfo(), locale = FALSE))
      sessInfoSec <- addTo(sessInfoSec, sesInfoPar)
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
    qcShow <- newParagraph("placeholder: show(qcm[[i]])")
    qcfig <- newFigure(file.path("figure", paste0("qcreport_fig", i, ".png")),
                       fileHighRes = file.path("figure", paste0("qcreport_fig", i, ".pdf")))
    ## section
    sec <- newSection(name(qcm[[i]]), class = "results")
    sec <- addTo(sec, qcShow, qcfig )
    return(sec)
}
