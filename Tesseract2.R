library(tesseract)
library(magick)
library(stringr)
library(tidyverse)

PatentsList <- str_split(Patents[,2], " ")

PatentsWords <- PatentsList %>% unlist() %>% unique()

DTM <- matrix(,length(PatentsList),1+length(PatentsWords)) %>% as.data.frame()
colnames(DTM) <- c('Ano',PatentsWords)
DTM[,1] <- Patents[,1]
DTM2<-DTM[,-which(colnames(DTM)=="")]

for(i in 1:length(PatentsList)) {
  PalavrasDaPatentes <- which(colnames(DTM2)  %in% PatentsList[[i]]==TRUE)
  QuaisPalavras <- colnames(DTM2)[PalavrasDaPatentes]
  #De todas as palavras na coluna, quais estão na patente i?
  QuantidadeDasPalavras <- table(PatentsList[[i]])[QuaisPalavras] #Das que stão, quantas elas são?
  DTM2[i,PalavrasDaPatentes] <- QuantidadeDasPalavras/length(PatentsList[[i]])
}


DTM2[is.na(DTM2)] <- 0
DTM2$Ano <- as.numeric(DTM2$Ano)
DTM2 <- DTM2 %>% as.data.frame()

#Vamos retirar as palavras que só aparecem uma vez, para diminuir dimensionalidade.

ApareceEmQuantasPatentes <- colSums(DTM2!=0) %>% as.matrix()
row.names(ApareceEmQuantasPatentes) <- colnames(DTM2)
DTM3<-DTM2[,which(ApareceEmQuantasPatentes!=1)]

#Retirar algumas stopwords.

DTM4 <- DTM3[,which(colnames(DTM3) %>% nchar() >2)]

#Retirar nomes próprios (ou próximo. Acab retirando outros palavras, também)
DTM5 <- DTM4[,grepl("\\b(?=[a-z])", colnames(DTM4), perl = TRUE)] %>% cbind(DTM4$Ano,.)
colnames(DTM5)[1] <- 'Ano'


#Preparando-se para fazer a análise.

DTM6 <- DTM5 %>% filter(Ano %in% c(1890:1904))
Anos <- DTM6$Ano %>% unique()

#Uma matriz para cada ano, para acelerar, dado que teria que repetir para cada objeto.

for(y in 1:length(Anos)) {
  assign(paste0('Patents',Anos[y]),DTM6 %>% filter(Ano == !!Anos[y]) %>% select(-Ano))
  assign(paste0('PatentsPrior',Anos[y]),DTM6
         %>% filter(Ano <= !!Anos[y]))
}


#Criando o BIDFm, que só depende do par de anos das patentes.

BIDFm <- matrix(,ncol(DTM6)-1,)

system.time(for(y in 1:length(Anos)) {
  for(j in 1:length(Anos)) {
    t = min(Anos[y],Anos[j])
    PatentsPriorT<- get(paste0('PatentsPrior',t))
    NPatentesPriorT <- nrow(PatentsPriorT)
    DocPriorTw <- colSums(PatentsPriorT!=0)
    BIDF = log(NPatentesPriorT / (1+DocPriorTw))
    BIDFm <- cbind(BIDFm,BIDF[-1])
    
  }
})


BIDFm <- BIDFm[,-1] %>% as.data.frame()

colnames(BIDFm) <-
  paste(expand.grid(Anos,Anos)[,2], expand.grid(Anos,Anos)[,1], sep=';')

DTM7 <- DTM6 %>% select(-Ano)


PatentsYear <- list()
rhoij<- matrix(NA,nrow(get(paste0('Patents',Anos[1]),)))

for(y in 1:(length(Anos)-1)) {
  for(i in nrow(DTM7)) {
    BIDFa <- BIDFm[paste(DTM6[i,]$Ano,as.character(Anos[y]),sep=';')] %>% as.matrix() #0.1 seg
    NonZero <- which(DTM7[i,]!=0)
    TFBIDFbi <- rep(0,ncol(DTM7)) %>% as.matrix() 
    TFBIDFbi[NonZero] <-
      
      as.matrix(DTM7[i,][NonZero])   *
      BIDFa[NonZero,] 
    TFBIDFi = TFBIDFbi/sqrt(sum(TFBIDFbi[NonZero]
                                
                                *TFBIDFbi[NonZero]))
    
    
    
    TFBIDFbj <- t(t(get(paste0('Patents',Anos[y])) %>% as.matrix()) * as.vector(BIDFa))
    TFBIDFj <- diag(1/(sqrt(rowSums(TFBIDFbj^2)))) %*% TFBIDFbj
    
    
    Vij <- t(t(TFBIDFj %>% as.matrix()) * as.vector(TFBIDFi))
    rhoij = cbind(rhoij,rowSums(Vij)) %>% as.data.frame()
    
  }
  PatentsYear[[y]] <- rhoij
  rhoij<- matrix(NA, nrow(get(paste0('Patents',Anos[y+1]))),)
}


Tempo <- c(
  
  system.time(BIDFm[paste(DTM6[i,]$Ano,as.character(Anos[j]),sep=';')] %>% as.matrix() )[3],
  
  system.time(TFBIDFbi <- rep(0,ncol(DTM7)) %>% as.matrix()   )[3],
  
  system.time( as.matrix(DTM3[i,][which(DTM7[i,]!=0)])   *
                 BIDFa[which(DTM7[i,]!=0),] )[3],
  
  system.time( TFBIDFbi/sqrt(sum(TFBIDFbi*TFBIDFbi)))[3], 
  
  system.time(t(t(get(paste0('Patents',Anos[y])) %>% as.matrix()) * as.vector(BIDFa)))[3],
  
  system.time(diag(1/(sqrt(rowSums(TFBIDFbj^2)))) %*% TFBIDFbj)[3],
  system.time(t(t(TFBIDFj %>% as.matrix()) * as.vector(TFBIDFi)))[3])


c(Tempo, sum(Tempo),(length(Anos))*nrow(DTM7)*sum(Tempo)/3600)


