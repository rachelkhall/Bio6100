# --------------------------------------
# FUNCTION q_box
# required packages: ggplot2
# description: creates box plot with one-way ANOVA results
# inputs: x vector of groups, y vector of response values (long form)
# outputs: boxplots and anova test
########################################
q_box <- function(x=NULL,y=NULL){

# function body
if (is.null(x) | is.null(y)) {
x <- rep(c("Control","N+","P+"),each=30)
y <- c(rgamma(n=30,shape=2,scale=3),
       rgamma(n=30,shape=2.5,scale=3),
       rgamma(n=30,shape=4,scale=2.5))
x <- factor(x,levels=c("Control","N+","P+"))
}
model <- summary(aov(y~x))
f_ratio <- paste0("F(", 
                  round(model[[1]][1,1],digits=3),
                  ",",
                  round(model[[1]][2,1],digits=3),
                  ") = ",
                  round(model[[1]][1,4],digits=3),
                  "; ")
p_val <- paste0("p = ",
                round(model[[1]][1,5],digits=3))

df <- data.frame(Category=x,Response=y)

figure_a <- ggplot2::ggplot(df) +
           aes(x=Category,y=Response) +
           geom_boxplot(fill="lightsalmon",
                        outlier.shape=NA) +
           geom_jitter(width=0.1,size=0.5) +
           theme_classic(base_size = 20,
           base_family="serif") +
           theme(plot.subtitle = element_text(size = 12),
           axis.title.y = element_text(angle = 90, 
                                       vjust = 0.5)) + 
  labs(subtitle = paste0(f_ratio,p_val)) +
  ylab("Y Variable")
                         
print(figure_a)
                  
                  
  

# return(model)

} # end of function q_box
# --------------------------------------
 # q_box()
