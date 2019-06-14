library("Biostrings")
library(stringr)
library(gdata)
#specify the sequences used as inserts
inserts<- read.csv(file="sequenceInfo.csv", header=TRUE, sep=",")
#specify the nanuq results from sequencing
nanuqReadout <- readFasta("fastaSeq8411.txt")

#manipulate the fastaFile into a dataframe
seq_name <- names(nanuqReadout)
sequence <- paste(nanuqReadout)
nanuqOrder <- data.frame(seq_name, sequence)
nanuqOrder$as.character.sequence.=levels(drop.levels(nanuqOrder$as.character.sequence.))


insertsToCheck <- inserts[55:66,]
insertsToCheck[,3] <- stringr::str_replace_all(insertsToCheck[,3], fixed(" "), "")


info=as.data.frame(sapply(as.character(insertsToCheck$Sequence), grepl, as.character(nanuqOrder$sequence)))

for (i in 1:12){
  flag=0
  #row column
  for (j in 1:12){
    if(info[i,j]==TRUE){
      print(paste(as.character(nanuqOrder$seq_name[i])," has ", insertsToCheck$Sequence.Name[j]))
      print('Sequence in question:')
      print(insertsToCheck$Sequence[j])
      print(paste(""))
      flag=1
    }
  }
  if(flag==0)
    print(paste(as.character(nanuqOrder$seq_name[i])," has no matching oligo"))
    print("")
}

