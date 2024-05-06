# ggplot III
# 11 April 2024 
# RKH 

install.packages("remotes")
library(remotes)
remotes::install_github("clauswilke/colorblindr") 
# update all of the recommended packages when prompted
# if an error is generated, re-start RStudio and re-run this line of code

library(ggplot2)
library(ggthemes)
library(patchwork)
library(colorblindr)
library(cowplot)
library(colorspace)
library(wesanderson)
library(ggsci)

d <- mpg

# Bar plots
# use to plot the counts of rows for a categorical variable
table(d$drv)
p1 <- ggplot(d) +
  aes(x=drv) + 
  geom_bar(color="black",fill="cornsilk")
print(p1)

# aesthetic mapping gives multiple groups for each bar
p1 <- ggplot(d) + 
  aes(x=drv,fill=fl) + 
  geom_bar()
print(p1)

# stacked, but need to adjust color transparency, which is "alpha"
p1 <- ggplot(d) + 
  aes(x=drv,fill=fl) + 
  geom_bar(alpha = 0.3, position="identity")
print(p1)

# better to use position = fill for stacking, but with equivalent height
p1 <- ggplot(d) + 
  aes(x=drv,fill=fl) + 
  geom_bar(position="fill")
print(p1)

# best to use position = dodge for multiple bars
p1 <- ggplot(d) + 
  aes(x=drv,fill=fl) +
  geom_bar(position="dodge",color="black",size=1)
print(p1)

# more typical "bar plot" has heights as the values themselves
d_tiny <- tapply(X=d$hwy,INDEX=as.factor(d$fl),FUN=mean) #calculate the means
print (d_tiny)

d_tiny <- data.frame(hwy=d_tiny) # create a single-column data frame
print(d_tiny)

d_tiny <- cbind(fl=row.names(d_tiny),d_tiny) # 
print(d_tiny)

p2 <- ggplot(d_tiny) +
  aes(x=fl,y=hwy,fill=fl) +
  geom_col()
print(p2)

# Use a box plot instead of standard "means" bars!

# basic boxplot is simple and informative
p1 <- ggplot(d) + 
  aes(x=fl,y=hwy,fill=fl) +
  geom_boxplot()
print(p1)

# now overlay the raw data
p1 <- ggplot(d) + 
  aes(x=fl,y=hwy) +
  geom_boxplot(fill="thistle",outlier.shape=NA) + 
  geom_point()
  #geom_point(position=position_jitter(width=0.1, height=0.7),
             #color="grey60",size=2)

print(p1)

# box plots are not good at showing how many of each data - more informative this way:
p1 <- ggplot(d) + 
  aes(x=fl,y=hwy) +
  geom_boxplot(fill="thistle",outlier.shape=NA) + 
  #geom_point()
  geom_point(position=position_jitter(width=0.1, height=0.7),color="grey60",size=2)

print(p1)

# Using Colors

# 1. Aesthetics
# a. Colors that are attractive
#   - large geoms (fills) - pale colors
#   - small geoms(lines,points) - bright colors
# b. Colors that highlight elements
#   - pale, grey to de-emphasize
#   - bright or saturated colors to emphasize
# c. Colors that are visible to the color blind
# d. Colors that convert well to black and white

# 2. Information content
# a. Discrete scale
#   - colors to group similar treatments
#   - neutral colors (black,grey,white) to indicate control groups
#   - Symbolic colors (heat=red, cool = blue, photosynthesis/growth=green, oligotrophic         =blue, eutrophic=brown, infected=red)
#   - Colors that map to chemical stains or gels, or even colors of organisms
# b. Continuous scale
#   - monochromatic (differing shades of 1 color)
#   - 2 tone chromatic scale (from color x to color y)
#   - 3 tone divergent scale (from color x through color y to color z)
# c. Use color information within and between graphs


# 3. show color names, hex in base R


# 4. show color schemes in colorbrewer

# Color visualizations
my_cols <- c("thistle","tomato","cornsilk","cyan","chocolate")
demoplot(my_cols,"map")
demoplot(my_cols,"bar")
demoplot(my_cols,"scatter")
demoplot(my_cols,"heatmap")
demoplot(my_cols,"spine")
demoplot(my_cols,"perspective")