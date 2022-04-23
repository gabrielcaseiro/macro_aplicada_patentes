library(dplyr)
library(daiR)
library(googleCloudStorageR)

# project_id <- "geolv-268112"
# 
# gcs_list_buckets(project_id)


files<-gcs_list_objects()
  files<-files$name
  files<-files[grep(".pdf",files)]



resp<-dai_async_tab(files[11],dest_folder = "text/")

gcs_list_objects()

tables <- tables_from_dai_file("1906.pdf-output-page-1-to-41.json")

colnames_adj<-function(x){
  t<-rbind(colnames(x), x)
  colnames(t)<-paste0("X",1:dim(t)[2])
  return(t)
  }

t<-lapply(tables,function(x){apply(x,2,as.character)})
t<-lapply(t, colnames_adj)
t<-lapply(t, data.frame,stringsAsFactors=F)
t<-t[2:length(t)]
t<-do.call(bind_rows,t)

saveRDS(t,"teste_1906.rds")

