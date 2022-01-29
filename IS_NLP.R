library(quanteda)
library(spacyr)
library(utf8)

lines <- readLines("spa_news_2021_10K-sentences.txt",encoding = "UTF-8")

# remove the line number and beginning tab
for (i in  1:length(lines)) {
  c = nchar(as.character(i))
  lines[i] = substring(lines[i], c+2)
}


# check UTF8 encoding
lines[!utf8_valid(lines)]

#Check character normalization. Specifically, the normalized composed form (NFC)
lines_NFC <- utf8_normalize(lines)
sum(lines_NFC != lines)
# we see the sum is not equal to 0, so from now on,we will use lines_NFC


spacy_initialize(model = "es_core_news_sm")

hist(nchar(lines_NFC),
     main = "Histogram of headline length",
     xlab = "Headline length (number of characters)",
     ylab = "Ocurrences"
)

tokens <- spacy_tokenize(lines_NFC,
                         #Parameters asigned by default:
                         #remove_punct = TRUE, #punt symbols are not tokens
                         #remove_url = FALSE, url elements are tokens
                         #remove_numbers = FALSE, numbers are tokens
                         #remove_separators = TRUE, spaces are NOT tokens
                         #remove_symbols = FALSE, symbols (like euro) are tokens
)#Returns a list

# quick tokens inspection
v_tokens <- unlist(tokens)
v_tokens[1:10]

length(v_tokens)
length(unique(v_tokens))

tk = head(sort(table(v_tokens), decreasing = TRUE), n = 30)
plot(tk, xlab = "Token", ylab = "Ocurrences")


texts_caps <- unlist(sample(lines_NFC, 2000))
names(texts_caps) <- paste("Headline.", 1:length(texts_caps)) #assigns a name to each string
corpus_capsQ <- corpus(texts_caps)
docvars(corpus_capsQ, field="article") <- 1:length(texts_caps) #docvar with chapter number

#Creates the dfm (document-feature matrix)
dfm_capsQ <- dfm(tokens(corpus_capsQ),
                 #Default values:
                 # tolower = TRUE #Convers to lowercase
                 # remove_padding = FALSE #Does padding (fills with blanks)
)
#Does a dendrogram
distMatrix <-dist(as.matrix(dfm_capsQ), method="euclidean")
groups <-hclust(distMatrix , method="ward.D")
plot(groups,
     cex =0.25, #Size of labels
     hang= -1, #Same hight labels
     xlab = "", #Text of axis x
     ylab = "", #Text of axis y
     main = "" #Text of drawing
)
rect.hclust(groups, k=10)


texts_caps <- unlist(lines_NFC)
names(texts_caps) <- paste("Headline.", 1:length(texts_caps)) #assigns a name to each string
corpus_capsQ <- corpus(texts_caps)
docvars(corpus_capsQ, field="article") <- 1:length(texts_caps) #docvar with chapter number
corpus_capsQ


dfm_capsQ <- dfm(tokens(corpus_capsQ,
                        remove_punct = TRUE,
                          #Default values:
                          # remove_punct = FALSE,
                          # remove_symbols = FALSE,
                        remove_numbers = TRUE,
                          # remove_url = FALSE,
                          # remove_separators = TRUE,
                          # split_hyphens = FALSE
                        ),
                 #Default values:
                 # tolower = TRUE #Convert to lowercase
                 # remove_padding = FALSE #Does padding (fill up blanks)
                 )

dfm_capsQ_filtered <- dfm_remove(dfm_capsQ, stopwords("es"))

tf = topfeatures(dfm_capsQ_filtered, n = 30)
topfeatures(dfm_capsQ_filtered, decreasing = FALSE, n = 30)
