## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
rm(list=ls())


## ----load pdftools to extract values and tidyverse to process------------
library(pdftools)
suppressMessages(library(tidyverse))


## ----extract 96-well from pdf-file, echo=T-------------------------------
file <- "template_data.pdf"
pdf_file <- file.path("~/Desktop/R/1_Projects/Extract_data_from_pdf/data/base/",file)
text <- suppressMessages(pdf_text(pdf_file))
print(text)


## ----process data with tidyverse-----------------------------------------
text <- strsplit(text, "\n")
text_dat <- as.data.frame(text)
print(text_dat)


## ----rows containing data of interest, echo=T----------------------------
i = 1
for(i in 1:nrow(text_dat)){
  if("A" == strsplit(as.character(text_dat[i,]), "\\s+")[[1]][1])
    {n = as.numeric(i)}else(i <- i + 1)
    }
print(as.character(text_dat[n:(n+7),]))


## ----select row containing actual data-----------------------------------
text_values <- text_dat[n:(n+7),]
text_values <- as.character(text_values)
text_values <- as.data.frame(text_values)
print(text_values)


## ----process actual data-------------------------------------------------
dat <- separate(text_values,text_values,into = c(as.character(c(0:12))), sep="\\s+")
str(dat)


## ----tidy data frame-----------------------------------------------------
tidy.dat <- dat[,2:13]
tidy.dat <- sapply(tidy.dat, as.numeric)
row.names(tidy.dat) <- dat[,1]
tidy.dat <- as.data.frame(tidy.dat)
str(tidy.dat, digits.d = 4)
print(tidy.dat)

