# --------------------------------------
# FUNCTION q_scat
# required packages: none
# description:
# inputs:
# outputs:
########################################
q_scat <- function(x = NULL, y = NULL){

# function body
  if(is.null(x) | is.null(y)) {
    x <- runif(20)
    y <- runif(20)
  }
  df <- data.frame(x = x, y = y,x2=x^2)
  my_mod <- summary(lm(y ~ x, data = df))
  q_mod <- summary(lm(y~x + x2,data=df))
  
  intercept <- paste("y = ",
               round(my_mod$coefficients[1,1], 
               digits = 3))
  
  q_intercept <- paste("y = ",
                       round(q_mod$coefficients[1,1], 
                       digits = 3))
  
  slope <- paste(" + ", 
                 round(my_mod$coefficients[2, 1], 
                       digits = 3), 
                 "x;  ", 
                 sep = "")
  
  q_slope <- paste(" + ", 
                 round(q_mod$coefficients[2, 1], 
                       digits = 3), 
                 "x ", 
                 sep = "")
  
  q_slope2 <- paste(" + ", 
                   round(q_mod$coefficients[3, 1], 
                         digits = 3), 
                   "x(2);  ", 
                   sep = "")
  
  r2 <- paste("r2 = ", 
                round(my_mod$r.squared, 
                      digits = 3), 
                ";  ", 
                sep = "")
  q_r2 <- paste("r2 = ", 
              round(q_mod$r.squared, digits = 3), 
              ";  ", 
              sep = "") 

  q_p_val <- paste("p = ", 
                 round(q_mod$coefficients[2, 4],
                       digits = 3), 
                 ";  ", 
                 sep = "")
  
  p_val <- paste("p = ", 
                 round(my_mod$coefficients[2, 4], 
                       digits = 3),
                 ";  ", 
                 sep = "")
  
  q_p_val2 <- paste("p(2) = ",
                 round(q_mod$coefficients[3, 4],
                       digits = 3),
                 ";  ", 
                 sep="")
  
  adj_r2 <- paste("adj.r2 = ", 
                  round(my_mod$adj.r.squared, 
                        digits = 3)) 
  
  q_adj_r2 <- paste("adj.r2 = ", 
                  round(q_mod$adj.r.squared, 
                        digits = 3))             
  
  z <- ggplot2::ggplot(df) +
                aes(x = x, y = y) + 
                geom_smooth(method = "lm", 
                            linewidth = 0.5,se=0) + 
                geom_smooth(method = "lm", 
                            formula = y ~ x + I(x^2),
                            linewidth = 0.5, 
                            color = "red",
                            se=0) + 
                geom_point(size=5,shape=21,fill="grey90") + 
                theme_bw(base_size = 20,
                              base_family="serif") +
                theme(plot.subtitle = element_text(size = 12),
                      axis.title.y = element_text(angle = 90, 
                      vjust = 0.5)) + 
                labs(subtitle = paste0(intercept, 
                                       slope, 
                                       r2, 
                                       p_val,
                                       adj_r2,
                                       "\n",
                                       q_intercept,
                                       q_slope,
                                       q_slope2,
                                       q_r2,
                                       q_p_val,
                                       q_p_val2,
                                       q_adj_r2)) +
    xlab("X Variable") +
    ylab("Y Variable")
  plot(z)

} # end of function q_scat
# --------------------------------------
  q_scat()
