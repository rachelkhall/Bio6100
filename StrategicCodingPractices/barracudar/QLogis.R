# --------------------------------------
# FUNCTION q_logis
# required packages: none
# description:
# inputs:
# outputs:
########################################
q_logis <- function(x=NULL,y=NULL){

# function body
 if(is.null(x) | is.null(y)){
   x <- sort(rgamma(n=40,shape=5,scale=5))
  y <- sample(rep(c(1,0),each=20),prob=seq_len(40))
 }
  df <- data.frame(x,y)
  log_reg_model <- glm(y ~ x,
                   data=df,
                   family=binomial(link=logit))
  my_mod <- summary(log_reg_model)
  
  
  intercept <- paste("y = ",
                     round(my_mod$coefficients[1,1], 
                           digits = 3))
  slope <- paste(" + ", 
                 round(my_mod$coefficients[2, 1], 
                       digits = 3), 
                 "x;  ", 
                 sep = "") 

  p_val <- paste("p = ", 
                 round(my_mod$coefficients[2, 4], 
                       digits = 3),
                 sep = "")
  p1 <- ggplot2::ggplot(data=df, aes(x=x,y=y)) +
    theme_bw(base_size = 20,
             base_family="serif") +
    stat_smooth(method=glm, 
                method.args=list(family=binomial),
                linewidth=0.5,
                se=0) +
    geom_point(size=5,shape=21,fill="grey90") + 
    # ylim(c(0,1.2))
    ylab("Probability") +
    xlab("X Variable") +
    theme(plot.subtitle = element_text(size = 15),
          axis.title.y = element_text(angle = 90, 
                                      vjust = 0.5)) + 
    labs(subtitle = paste0(intercept, 
                           slope, 
                           p_val))
  print(p1)


} # end of function q_logis
# --------------------------------------
 # q_logis()
