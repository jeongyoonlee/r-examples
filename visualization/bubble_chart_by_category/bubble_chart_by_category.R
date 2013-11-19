#!/usr/bin/env Rscript
#------------------------------------------------------------------------------
# Bubble chart for data with 4 dimension (score, rate, category, count)
# - use x- and y-axis for score and rate
# - use colors to code categories
# - use bubble sizes to represent counts
# - written by Jeong-Yoon Lee (jeongyoon.lee1@gmail.com)
#------------------------------------------------------------------------------

# Data file
in_file = 'data.tab'


# Output image properties
IMG_DPI = 300
IMG_WIDTH = 8
IMG_HEIGHT = 6


# Parse input arguments.
args = commandArgs(T)
if (length(args) != 1) {
    stop('Usage: bubble_chart_by_category output_file_name.png\n')
}

out_file = args[1]


# Import library.
require(ggplot2)


# Load data for plotting.
# Data has been aggregated by category by using aggregate().
df = read.delim(in_file, header=T, stringsAsFactor=F)


# Draw and save the bubble chart.
png(out_file, width=IMG_WIDTH * IMG_DPI, height=IMG_HEIGHT * IMG_DPI,
    res=IMG_DPI)
p = ggplot(df, aes(SCORE, RETURN_RATE))
p + geom_point(aes(colour=CATEGORY, size=COUNT), alpha=0.9) + 
    scale_size_area(max_size=20) +
    scale_x_continuous(breaks=sort(unique(df$SCORE))) + 
    theme(panel.background = element_rect(fill='#f0f0f0')) + 
    guides(colour=guide_legend(order=1, override.aes=list(size=5)),
           size=guide_legend(order=2, override.aes=list(colour='gray'))) +
    xlab('Score') + 
    ylab('Return Rate (%)')
dev.off()
