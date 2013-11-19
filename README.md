# SUMMARY
Example codes using R for data analysis

# Visualization
## wordcloud_obama_inaugural
* read and extract texts from the White House's Obama 2009 inaugural address page.
* build a text-document matrix using TF-IDF.
* draw the wordcloud by the TF-IDF scores and save it as a PNG file.

Usage:

    $ ./wordcloud_obama_inaugural.R wordcloud.png

Output:

![Wordcloud](/visualization/wordcloud_obama_inaugural/wordcloud_obama_inagural.png)

## bubble_chart_by_category
* draw a bubble chart for data with 4 dimension (score, rate, category, count) using ggplot.
* use x- and y-axis for score and rate
* use colors to code categories
* use bubble sizes to represent counts

Usage:

    $ ./bubble_chart_by_category.R bubble_chart_by_category.png

Output:

![Wordcloud](/visualization/bubble_chart_by_category/bubble_chart_by_category.png)
