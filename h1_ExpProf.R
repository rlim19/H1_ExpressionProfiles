library(Biobase)
library(GEOquery)
library(plyr)

# get the exp profiles from GEO
h1_rep1 <- getGEO('GSM661186', destdir='.')
h1_rep2 <- getGEO('GSM661187', destdir='.')
h1_rep1 <- getGEO(filename='GSM661186.soft')
h1_rep2 <- getGEO(filename='GSM661187.soft')

#check datasets
colnames(Table(h1_rep1))
colnames(Table(h1_rep2))
Table(h1_rep1)[1000:1005,]

#annotations
Meta(h1_rep1)$platform
Meta(h1_rep2)$platform
# using GPL4133

# load GPL4133's annotation files
gp4133 <- getGEO('GPL4133', destdir='.')
gp4133 <- getGEO(filename='GPL4133.soft')
Meta(gp4133)$title
colnames(Table(gp4133))
Table(gp4133)[10:15, 10]

# get only ID and gene_id
gp4133_geneID <- Table(gp4133)[, c("ID", "ENSEMBL_ID")]


# get the dataframe of exp profiles
h1_rep1 <- Table(h1_rep1)
h1_rep2 <- Table(h1_rep2)
colnames(h1_rep1) <- c('ID','VALUE')
colnames(h1_rep2) <- c('ID', 'VALUE')
head(h1_rep1)
head(h1_rep2)

dim(h1_rep1)
dim(h1_rep2)

# map dataset with gene id (ensembl_id)
h1_rep1Gene <- join(h1_rep1, gp4133_geneID, by='ID')
h1_rep2Gene <- join(h1_rep2, gp4133_geneID, by='ID')

head(h1_rep1Gene)
head(h1_rep2Gene)