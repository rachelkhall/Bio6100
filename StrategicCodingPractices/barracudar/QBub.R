# --------------------------------------
# FUNCTION q_bub
# required packages: none
# description:
# inputs:
# outputs:
########################################
q_bub <- function(x = NULL, y = NULL, z = NULL){

# function body
  if(is.null(x) | is.null(y) | is.null(z)) {
    x <- runif(20)
    y <- runif(20)
    z <- runif(20)
  }
  df <- data.frame(x = x, y = y,z = z)
  df <- df[order(df$z, decreasing=TRUE),]
  my_mod <- summary(lm(z ~ x + y, data = df))
#  q_mod <- summary(lm(y~x + x2,data=df))
  
  intercept <- paste("z = ",
               round(my_mod$coefficients[1,1], 
               digits = 3))
  
  # q_intercept <- paste("y = ",
  #                      round(q_mod$coefficients[1,1], 
  #                      digits = 3))
  
  slope_x <- paste(" + ", 
                 round(my_mod$coefficients[2, 1], 
                       digits = 3), 
                 "x ", 
                 sep = "")
  slope_y <- paste(" + ", 
                   round(my_mod$coefficients[3, 1], 
                         digits = 3), 
                   "y;", "\n", 
                   sep = "")  
  # q_slope <- paste(" + ", 
  #                round(q_mod$coefficients[2, 1], 
  #                      digits = 3), 
  #                "x ", 
  #                sep = "")
  
  # q_slope2 <- paste(" + ", 
  #                  round(q_mod$coefficients[3, 1], 
  #                        digits = 3), 
  #                  "x(2);  ", 
  #                  sep = "")
  
  r2 <- paste("r2 = ", 
                round(my_mod$r.squared, 
                      digits = 3), 
                "; ", 
                sep = "")
  # q_r2 <- paste("r2 = ", 
  #             round(q_mod$r.squared, digits = 3), 
  #             ";  ", 
  #             sep = "") 
  # 
  # q_p_val <- paste("p = ", 
  #                round(q_mod$coefficients[2, 4],
  #                      digits = 3), 
  #                ";  ", 
  #                sep = "")
  # 
  p_x <- paste("p(x) = ", 
                 round(my_mod$coefficients[2, 4], 
                       digits = 3),
                 ";  ", 
                 sep = "")
  p_y <- paste("p(y) = ", 
                 round(my_mod$coefficients[3, 4], 
                       digits = 3),
                 sep = "")
  
  # q_p_val2 <- paste("p(2) = ",
  #                round(q_mod$coefficients[3, 4],
  #                      digits = 3),
  #                ";  ", 
  #                sep="")
  
  # adj_r2 <- paste("adj.r2 = ", 
  #                 round(my_mod$adj.r.squared, 
  #                       digits = 3)) 
  # 
  # q_adj_r2 <- paste("adj.r2 = ", 
  #                 round(q_mod$adj.r.squared, 
  #                       digits = 3))             
  # 
  zz <- ggplot2::ggplot(df) +
                aes(x = x, y = y,size=z) + 
                # geom_smooth(method = "lm", 
                #             linewidth = 0.5,se=0) + 
                # geom_smooth(method = "lm", 
                #             formula = y ~ x + I(x^2),
                #             linewidth = 0.5, 
                #             color = "red",
                #             se=0) + 
                geom_point(shape=21,
                           color="black",
                           fill="grey20",
                           alpha=0.5) + 
                theme_classic(base_size = 20,
                              base_family="serif") +
                theme(plot.subtitle = element_text(size = 12),
                      axis.title.y = element_text(angle = 90, 
                      vjust = 0.5)) + 
                labs(subtitle = paste0(intercept, 
                                       slope_x, 
                                       slope_y,
                                       r2, 
                                       p_x,
                                       p_y)) +
                                       # adj_r2,
                                       # "\n",
                                       # q_intercept,
                                       # q_slope,
                                       # q_slope2,
                                       # q_r2,
                                       # q_p_val,
                                       # q_p_val2,
                                       # q_adj_r2)) +
    xlab("X Variable") +
    ylab("Y Variable")
  plot(zz)

} # end of function q_bub
# --------------------------------------
  # q_bub()
