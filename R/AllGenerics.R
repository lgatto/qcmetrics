setGeneric("status", function(object) standardGeneric("status"))
setGeneric("status<-", function(object, value) standardGeneric("status<-"))

setGeneric("name", function(object) standardGeneric("name"))
setGeneric("name<-", function(object, value) standardGeneric("name<-"))

setGeneric("qcdata", function(object, x) standardGeneric("qcdata"))
setGeneric("qcdata<-", function(object, ..., value) standardGeneric("qcdata<-"))

setGeneric("show<-", function(object, value) standardGeneric("show<-"))
setGeneric("plot<-", function(object, value) standardGeneric("plot<-"))

setGeneric("qcReport", function(object, ...) standardGeneric("qcReport"))
