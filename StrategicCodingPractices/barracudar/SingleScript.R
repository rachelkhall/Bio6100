# Strategic Coding Practices
# Tools for Working with a single script
# Nicholas J. Gotelli
# University of Vermont
# 19 July 2023

# Header ----

# Toggle outline with <CTRL><SHIFT>o

# Create header by adding 4 (or more) hyphens or carets at end of a line
# Use grey arrows in margin to fold or unfold sections!

## Subheader ----
# Again, code in these sections can be folded to hide

# Four Important Shortcuts ----
## <CTRL><Enter> ----
# This short cut runs one line of R code at a time
# We will be using this command today

## <CTRL><SHIFT><C> ----
# Use to toggle and comment or uncomment lines of code
# When coding, do not delete lines, toggle them out
# a <- 10
# b <- a + pi
# print(b)

## <CTRL><SHIFT><ENTER>----
# This command runs all of the lines of code in your program AND echoes any script
# It behaves as if each line were entered on console (sometimes very messy,so use <CTRL l> to flush console)#

## <CTRL><SHIFT><S> ----
# This command runs (=sources) all lines of code in your program,
# but does NOT echo any console output
a <- "This message only shows when output is echoed"
a
b <- "This message always shows because it is printed"
print(b)

# Using code snippets ----
# Text macros available in Rstudio
# Suggest naming them as m.* so you can easily recall your set
# Must use tab to indent in second line of snippet editor
# in script, carefully type m.* and use tab complete
# this puts the snippet into your script just as you wrote it

## Adding a placeholder name ----
# use format ${1:placeholder}

## Repeat the placeholder name ----
# Use ${1} in other places
# Set up ${2:name} for additional labels


## Insert R code in a snippet ----
# `r validLineOfRCode`

