# --------------------------------------
# FUNCTION q_con1
# required packages: ggplot
# description: calculates bootstrap chi-square for groups (one-way)
# inputs: x = a vector of group names (i.e. in the long form)
# outputs: Graph and bootstrap chi-square test
########################################
q_con1 <- function(x=NULL){

# function body
if (is.null(x)) {
  x <- c(rep("Control",rpois(n=1,lambda=10)), 
         rep("Low",12), 
         rep("High",1),
         rep("Caged",7))
}
 z <- chisq.test(table(x),simulate.p.value = TRUE, B=10000)
 p_val <- paste0("p = ", round(z$p.value,digits=3),"\n"," (bootstrap with 10,000 randomizations)")
 chi <- paste0("Chi-square = ",round(z$statistic,digits=3), "; ")
 
  df <- data.frame(Category=x)
 if(is.null(x)){ df$Category <- factor(df$Category,levels=c("Control",
                                             "Caged",
                                             "Low",
                                             "High"))} else df$Category <- factor(df$Category)

    figure_a <-  ggplot2::ggplot(df) +
          aes(x=Category) +
          geom_bar(color="black", fill="darkturquoise") +
          theme_classic(base_size = 20,
           base_family="serif") +
           ylab("Count") +
theme(plot.subtitle = element_text(size = 15),
      axis.title.y = element_text(angle = 90, 
                                  vjust = 0.5)) + 
  labs(subtitle = paste0(chi,
                         p_val)) 
  
print(figure_a)                 
}
 # end of function q_con1
# --------------------------------------
  # q_con1()

