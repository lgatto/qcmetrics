setGeneric("status", function(object) standardGeneric("status"))
setGeneric("status<-", function(object, value) standardGeneric("status<-"))

setGeneric("name", function(object) standardGeneric("name"))
setGeneric("name<-", function(object, value) standardGeneric("name<-"))

setGeneric("qcenv", function(object) standardGeneric("qcenv"))
setGeneric("qcenv<-", function(object, value) standardGeneric("qcenv<-"))
setGeneric("qcdata", function(object, x) standardGeneric("qcdata"))
setGeneric("qcdata<-", function(object, ..., value) standardGeneric("qcdata<-"))

## setGeneric("metadata", function(object, ...) standardGeneric("metadata"))
## setGeneric("metadata<-", function(object, value) standardGeneric("metadata<-"))
setGeneric("mdata", function(object, ...) standardGeneric("mdata"))
setGeneric("mdata<-", function(object, value) standardGeneric("mdata<-"))

setGeneric("show<-", function(object, value) standardGeneric("show<-"))
setGeneric("plot<-", function(object, value) standardGeneric("plot<-"))

setGeneric("qcReport", function(object, ...) standardGeneric("qcReport"))
