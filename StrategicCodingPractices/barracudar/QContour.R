# --------------------------------------
# FUNCTION q_contour
# required packages: none
# description:
# inputs:
# outputs:
########################################
q_contour <- function(x = NULL, y = NULL){

# function body
  if(is.null(x) | is.null(y)) {
    x <- runif(20)
    y <- runif(20)
    
  }
  df <- data.frame(x = x, y = y)
  # 
  zz <- ggplot2::ggplot(df) +
                aes(x = x, y = y) + 
    geom_density_2d() +
    geom_point() +           
    theme_classic(base_size = 20,
             base_family="serif") +
    xlab("X Coordinate") +
    ylab("Y Coordinate")
  plot(zz)

} # end of function q_contour
# --------------------------------------
  # q_contour()
