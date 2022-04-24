library(dplyr)
library(readr)
library(stringr)

files<-list.files('aws_ocr/','aws.rds')

# 1890:

l<-readRDS(paste0("aws_ocr/",files[1]))

unique(unlist(lapply(l, ncol)))

t<-data.frame(do.call(rbind,l),stringsAsFactors = F)
  colnames(t)<-t[1,]
  t<-t[!t$OBJECTO=="OBJECTO",]

write.csv2(t,"temp/t1.csv",row.names = F)

# t <- read_delim("temp/t1_at.csv", delim = ";", 
#                          escape_double = FALSE, col_types = cols(N = col_character()), 
#                          locale = locale(encoding = "ISO-8859-2"), 
#                          trim_ws = TRUE)

# 1891:

l<-readRDS(paste0("aws_ocr/",files[2]))

unique(unlist(lapply(l, ncol)))

t<-data.frame(do.call(rbind,l),stringsAsFactors = F)
colnames(t)<-t[1,]
t<-t[!t$OBJECTO=="OBJECTO",]

write.csv2(t,"temp/t2.csv",row.names = F)

# 1892:

l<-readRDS(paste0("aws_ocr/",files[3]))

unique(unlist(lapply(l, ncol)))

t<-data.frame(do.call(rbind,l),stringsAsFactors = F)
colnames(t)<-t[1,]
t<-t[!t$OBJECTO=="OBJECTO",]

write.csv2(t,"temp/t3.csv",row.names = F)

# 1893:

l<-readRDS(paste0("aws_ocr/",files[4]))

unique(unlist(lapply(l, ncol)))

t<-data.frame(do.call(rbind,l),stringsAsFactors = F)
colnames(t)<-t[1,]
t<-t[!t$OBJECTO=="OBJECTO",]

colnames(t)[2]<-"N"

write.csv2(t,"temp/t4.csv",row.names = F)

# 1894:

l<-readRDS(paste0("aws_ocr/",files[5]))

unique(unlist(lapply(l, ncol)))

t<-data.frame(do.call(rbind,l),stringsAsFactors = F)
colnames(t)<-t[1,]
t<-t[!t$OBJECTOS=="OBJECTOS",]

colnames(t)[2]<-"N"

write.csv2(t,"temp/t5.csv",row.names = F)

# 1895:

l<-readRDS(paste0("aws_ocr/",files[6]))

unique(unlist(lapply(l, ncol)))

t<-data.frame(do.call(rbind,l),stringsAsFactors = F)
colnames(t)<-t[1,]
t<-t[!t$OBJECTO=="OBJECTO",]

colnames(t)[2]<-"N"

write.csv2(t,"temp/t6.csv",row.names = F)

# 1896:

l<-readRDS(paste0("aws_ocr/",files[7]))

unique(unlist(lapply(l, ncol)))

t<-data.frame(do.call(rbind,l),stringsAsFactors = F)
colnames(t)<-t[1,]
t<-t[!(t$CONCESSIONARIOS=="CONCESSIONARIOS"|t$CONCESSIONARIOS=="CONCBSSIOSARIOS"),]

colnames(t)[2]<-"N"

write.csv2(t,"temp/t7.csv",row.names = F)

# 1897:

l<-readRDS(paste0("aws_ocr/",files[8]))

unique(unlist(lapply(l, ncol)))

l[[10]]<-l[[10]][,2:8]

t<-data.frame(do.call(rbind,l),stringsAsFactors = F)
colnames(t)<-t[1,]
t<-t[!t$OBJECTO=="OBJECTO",]

colnames(t)[2]<-"N"

write.csv2(t,"temp/t8.csv",row.names = F)


# 1898:

l<-readRDS(paste0("aws_ocr/",files[9]))

unique(unlist(lapply(l, ncol)))

l[[15]]<-l[[15]][,c(1:6,8)]

t<-data.frame(do.call(rbind,l),stringsAsFactors = F)
colnames(t)<-t[1,]
t<-t[!t$OBJECTO=="OBJECTO",]

colnames(t)[2]<-"N"

write.csv2(t,"temp/t9.csv",row.names = F)

# 1899:

l<-readRDS(paste0("aws_ocr/",files[10]))

unique(unlist(lapply(l, ncol)))

t<-data.frame(do.call(rbind,l[lapply(l, ncol)==5]),stringsAsFactors = F)
  temp<-data.frame(do.call(rbind,l[lapply(l, ncol)==8]),stringsAsFactors = F)
  temp<-temp[,c(1:2,6:8)]
  colnames(temp)<-colnames(t)
  t<-rbind(t,temp)
    temp<-data.frame(do.call(rbind,l[lapply(l, ncol)==9]),stringsAsFactors = F)
    temp<-temp[,c(1:2,7:9)]
    colnames(temp)<-colnames(t)
    t<-rbind(t,temp)
      temp<-data.frame(do.call(rbind,l[lapply(l, ncol)==6]),stringsAsFactors = F)
      temp1<-temp[1:35,]
        temp1$X2<-paste(temp1$X2,temp1$X3," ")
        temp1<-temp1%>%select(-X3)
        colnames(temp1)<-colnames(t)
      temp<-bind_rows(temp1,temp[36:nrow(temp),1:5])
      t<-rbind(t,temp)
      
colnames(t)<-t[1,]
t<-t[!t$OBJECTO=="OBJECTO",]

colnames(t)[1]<-"N"

write.csv2(t,"temp/t10.csv",row.names = F)

# 1900:

l<-readRDS(paste0("aws_ocr/",files[11]))

unique(unlist(lapply(l, ncol)))

t<-data.frame(do.call(rbind,l[lapply(l, ncol)==5]),stringsAsFactors = F)
  temp<-data.frame(do.call(rbind,l[lapply(l, ncol)==8]),stringsAsFactors = F)
  temp$X2<-paste(temp$X2,temp$X3," ")
  temp<-temp[,c(1:2,6:8)]
  colnames(temp)<-colnames(t)
  t<-rbind(t,temp)
    temp<-data.frame(do.call(rbind,l[lapply(l, ncol)==6]),stringsAsFactors = F)
    temp<-temp[,1:5]
    colnames(temp)<-colnames(t)
    t<-rbind(t,temp)

colnames(t)<-t[1,]
t<-t[!t$OBJECTO=="OBJECTO",]

colnames(t)[1]<-"N"

write.csv2(t,"temp/t11.csv",row.names = F)


# 1901:

l<-readRDS(paste0("aws_ocr/",files[12]))

temp<-l[[17]]
  temp[,2]<-paste(temp[,2],temp[,3],sep='')
  temp<-temp[,c(1:2,4:6)]
  l[[17]]<-temp

unique(unlist(lapply(l, ncol)))

t<-data.frame(do.call(rbind,l[lapply(l, ncol)==5]),stringsAsFactors = F)
  temp<-data.frame(do.call(rbind,l[lapply(l, ncol)==6]),stringsAsFactors = F)
  temp<-temp[,1:5]
  colnames(temp)<-colnames(t)
  t<-rbind(temp,t)

colnames(t)<-t[1,]
t<-t[!t$OBJECTO=="OBJECTO",]

colnames(t)[1]<-"N"

write.csv2(t,"temp/t12.csv",row.names = F)

# 1902:

l<-readRDS(paste0("aws_ocr/",files[13]))

temp<-l[[16]]
temp[,2]<-paste(temp[,2],temp[,3],sep='')
temp<-temp[,c(1:2,4:6)]
l[[16]]<-temp

temp<-l[[20]]
temp[,2]<-paste(temp[,2],temp[,3],sep='')
temp<-temp[,c(1:2,4:6)]
l[[20]]<-temp

unique(unlist(lapply(l, ncol)))

t<-data.frame(do.call(rbind,l[lapply(l, ncol)==5]),stringsAsFactors = F)
  temp<-data.frame(do.call(rbind,l[lapply(l, ncol)==6]),stringsAsFactors = F)
  temp<-temp[,1:5]
  colnames(temp)<-colnames(t)
  t<-rbind(temp,t)

colnames(t)<-t[1,]
t<-t[!t$OBJECTO=="OBJECTO",]

colnames(t)[1]<-"N"

write.csv2(t,"temp/t13.csv",row.names = F)


# 1903:

l<-readRDS(paste0("aws_ocr/",files[14]))

temp<-l[[16]]
temp<-temp[,c(1:2,4:6)]
l[[16]]<-temp

temp<-l[[29]]
  temp[,4]<-paste(temp[,4],temp[,5],sep=' ')
  temp[,7]<-paste(temp[,7],temp[,8],sep=' ')
temp<-temp[,c(1,3,4,6,7)]
l[[29]]<-temp

temp<-l[[30]]
  temp[,2]<-paste(temp[,2],temp[,3],sep=' ')
  temp<-temp[,c(1,2,6,7,8)]
l[[30]]<-temp


unique(unlist(lapply(l, ncol)))

t<-data.frame(do.call(rbind,l[lapply(l, ncol)==5]),stringsAsFactors = F)
  temp<-data.frame(do.call(rbind,l[lapply(l, ncol)==6]),stringsAsFactors = F)
  temp<-temp[,1:5]
  colnames(temp)<-colnames(t)
  t<-rbind(temp,t)


colnames(t)<-t[1,]
t<-t[!t$OBJECTO=="OBJECTO",]

colnames(t)[1]<-"N"

write.csv2(t,"temp/t14.csv",row.names = F)

# 1904:

l<-readRDS(paste0("aws_ocr/",files[15]))

unique(unlist(lapply(l, ncol)))

temp<-l[[13]]
  temp<-temp[,c(1:2,4:9)]
  l[[13]]<-temp


t<-data.frame(do.call(rbind,l[lapply(l, ncol)==5]),stringsAsFactors = F)
  temp<-data.frame(do.call(rbind,l[lapply(l, ncol)==6]),stringsAsFactors = F)
  temp1<-temp[1:53,]
  temp1$X2<-str_squish(paste(temp1$X2,temp1$X3,sep=" "))
  temp1<-temp1[,c(1:2,4:6)]
  colnames(temp1)<-colnames(t)
  t<-rbind(t,temp1)
    temp1<-temp[54:nrow(temp),]
    temp1<-temp1[,1:5]
    colnames(temp1)<-colnames(t)
    t<-rbind(t,temp1)

colnames(t)<-t[2,]
t<-t[!t$OBJECTO=="OBJECTO",]

colnames(t)[1]<-"N"

write.csv2(t,"temp/t15.csv",row.names = F)

# 1906:

l<-readRDS(paste0("aws_ocr/",files[17]))

unique(unlist(lapply(l, ncol)))

t<-data.frame(do.call(rbind,l[lapply(l, ncol)==8]),stringsAsFactors = F)
  temp<-data.frame(do.call(rbind,l[lapply(l, ncol)==7]),stringsAsFactors = F)
  t<-bind_rows(t,temp)
    temp<-data.frame(do.call(rbind,l[lapply(l, ncol)==9]),stringsAsFactors = F)
    temp$X8<-paste(temp$X8,temp$X9,sep = " ")
    t<-bind_rows(t,temp[1:8])
  
colnames(t)<-t[2,]
colnames(t)[8]<-"OBSERVAÇÔES"

t<-t[!t$`OBJECTO DA INVENÇÃO`=="OBJECTO DA INVENÇÃO",]
  t<-t[!t$Nacionalidade=="Nacionalidade",]
  t<-t[!t$Nacionalidade=="CONCESSTONARIO",]
  t<-t[!t$Nacionalidade=="CONCESSIONARIO",]
  t<-t[!t$Nacionalidade=="CONCESSIOSARIO",]


colnames(t)[1]<-"N"

write.csv2(t,"temp/t17.csv",row.names = F)

# 1907:

l<-readRDS(paste0("aws_ocr/",files[18]))

unique(unlist(lapply(l, ncol)))

t<-data.frame(do.call(rbind,l[lapply(l, ncol)==8]),stringsAsFactors = F)
  temp<-t[1:26,]
  temp$X2<-paste(temp$X2,temp$X3,sep = " ")
  temp$X3<-NULL
  colnames(temp)<-colnames(t)[1:7]
    temp1<-t[27:73,]
    temp1$X4<-paste(temp1$X4,temp1$X5,sep = " ")
    temp1$X5<-NULL
    colnames(temp1)<-colnames(t)[1:7]
  t<-bind_rows(temp,temp1,t[74:nrow(t),])


temp<-data.frame(do.call(rbind,l[lapply(l, ncol)==7]),stringsAsFactors = F)
  t<-bind_rows(t,temp)
temp<-data.frame(do.call(rbind,l[lapply(l, ncol)==9]),stringsAsFactors = F)
temp$X8<-paste(temp$X8,temp$X9,sep = " ")
t<-bind_rows(t,temp[1:8])

colnames(t)<-t[2,]
colnames(t)[8]<-"OBSERVAÇÔES"
colnames(t)[7]<-"OBJECTO DA INVENÇÃO"


t<-t[!t$`OBJECTO DA INVENÇÃO`=="OBJECTO DA INVENÇÃO",]
t<-t[!t$Nacionalidade=="Nacionalidade",]
t<-t[!t$Nacionalidade=="CONCESSTONARIO",]
t<-t[!t$Nacionalidade=="CONCESSIONARIO",]
t<-t[!t$Nacionalidade=="CONCESSIOSARIO",]


colnames(t)[1]<-"N"

write.csv2(t,"temp/t17.csv",row.names = F)



##############################################################

library(data.table)
library(dplyr)

files_c<-list.files("temp",".txt")
  files_c<-c(files_c,"t1_at.csv","t4.csv")

files_c<-files_c[order(files_c)]  
  anos<-c(1890,1899:1904,1906,1891:1898)
  
dt<-NULL  
  
for (i in 1:16) {
  
temp<-fread(paste0("temp/",files_c[i]),data.table = F,header = T)
n<-length(colnames(temp))
temp<-fread(paste0("temp/",files_c[i]),data.table = F,header = T,colClasses = rep("character",n))


if(n==7){colnames(temp)<-c("ID","N","CONCESSIONARIOS","RESIDENCIA","OBJECTO","DATA", "DURACAO" )}

if(n==5&i>1){colnames(temp)<-c("N","DATA","CONCESSIONARIOS","RESIDENCIA","OBJECTO")}

if(n==5&i==1){colnames(temp)<-c("N","CONCESSIONARIOS","RESIDENCIA","OBJECTO","DATA")}

if(n==8){colnames(temp)<-c("N","DATA","CONCESSIONARIOS","NACIONALIDADE","PROFISSAO","RESIDENCIA","OBJECTO","OBS")}

temp$ANO<-anos[i]

dt<-bind_rows(dt,temp)

}



saveRDS(dt,'dt_1890_1906_aws.rds')

