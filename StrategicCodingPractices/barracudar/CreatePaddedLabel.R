# --------------------------------------
# FUNCTION create_padded_labels
# required packages: none
# description: creates character string labels with padded zeroes
# inputs: number of labels, character string, optional file name suffix
# outputs: vector of labels (or file names)
########################################
create_padded_labels <- function(n=6,
                                 string="Toy", 
                                 suffix=NULL) {

# function body

  my_labels <-  paste0(string,formatC((1:n),
                                     width=max(c(3,nchar(as.character(n)))),
                                     format="d",
                                     flag="0"))
  if (!is.null(suffix)) my_labels <- paste0(my_labels,suffix)
  
return(my_labels)

} # end of create_padded_labels
# --------------------------------------
# create_padded_labels(suffix=".csv")
