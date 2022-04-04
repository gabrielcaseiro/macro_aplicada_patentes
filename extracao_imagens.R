library(rvest)
library(RSelenium)
library(dplyr)
library(readxl)

limites <- read_excel("macro_aplicada_patentes_anos.xlsx")


remDr <- remoteDriver(remoteServerAddr = "localhost",
                      port = 4445L,
                      browserName = "chrome")

remDr$open()

limites$pagfis_0[i]<-j

for (i in 6:nrow(limites)) {
  
  for (j in limites$pagfis_0[i]:limites$pagfis_1[i]) {
    
    print(paste0(i,"_",j))
    
    url<-paste0("http://memoria.bn.br/DocReader/DocReader.aspx?bib=873730&pagfis=",j)
    
    Sys.sleep(5)
    
    remDr$navigate(url)
    
    Sys.sleep(30)
    
    imgsrc <- read_html(remDr$getPageSource()[[1]]) %>%
      html_node(xpath = '//*[@id="DocumentoImg"]')%>%
      html_attr('src')

    download.file(paste0("http://memoria.bn.br/DocReader/", imgsrc), destfile = paste0("imagens/",limites$ANO[i],"_",j,".JPG"),mode = 'wb')
    
  }
  
}


remDr$close()
