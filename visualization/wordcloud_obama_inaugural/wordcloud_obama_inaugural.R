#!/usr/bin/env Rscript
#------------------------------------------------------------------------------
# Wordcloud from Obama's 2009 Inaugural Address
# - code referred from One R Tip A Day, http://goo.gl/9fYCOz
# - written by Jeong-Yoon Lee (jeongyoon.lee1@gmail.com)
#------------------------------------------------------------------------------

# Parse input arguments.
args = commandArgs(T)
if (length(args) != 1) {
    stop('Usage: wordcloud_obama_inaugural.R output_file_name\n')
}

out_file = args[1]

# Import libraries.
require(RColorBrewer)
require(SnowballC)
require(tm)
require(wordcloud)
require(XML)

# Definitions
URL_INAUGURAL_ADDRESS = 'http://www.whitehouse.gov/the-press-office/2013/01/21/inaugural-address-president-barack-obama'
XPATH_EXPRESSION = "/html/body/div[2]/div/div[4]/div[2]/div[1]/div/text()"

# Read URL into HTML tree.
doc = htmlTreeParse(URL_INAUGURAL_ADDRESS, useInternalNodes = T)

# Parse HTML to get texts.
nodes = getNodeSet(doc, XPATH_EXPRESSION)
texts = sapply(nodes, xmlValue)

# Build a corpus using TF-IDF.
corpus = Corpus(VectorSource(texts))
corpus = tm_map(corpus, function(x) iconv(enc2utf8(x), sub = "byte") )
corpus = tm_map(corpus, stripWhitespace)
corpus = tm_map(corpus, tolower)
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, c(stopwords('english'), 'applause'))

tdm = TermDocumentMatrix(corpus, 
                         control=list(weighting=function(x)
                                                    weightTfIdf(x, normalize=F),
                                      bounds=list(global=c(3,Inf))))
tdm = as.matrix(tdm)

# Sort the term document matrix by TF-IDF scores.
v = sort(rowSums(tdm), decreasing=T)
d = data.frame(word = names(v), freq=v)

# Draw and save the wordcloud.
pal2 = brewer.pal(8, "Dark2")
png(out_file, width=1280,height=800)
wordcloud(d$word, d$freq, scale=c(10, .1),
          random.order=F, rot.per=.4, colors=pal2)
dev.off()
