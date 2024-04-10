# --------------------------------------
# FUNCTION q_con2
# required packages: ggplot2,ggmosaic
# description: mosaic plot and chi-square test for two-way classification
# inputs: Category vector, Outcome vector (both in long form)
# outputs: Mosaic plot and chi-square test
########################################
q_con2 <- function(x=NULL,y=NULL){

# function body
if (is.null(x) | is.null(y)) {
   x <- rep(c("Control","Enriched","Disturbed","Caged"),
              times=rpois(lambda=c(30,40,10,40),
                          n=c(1,1,1,1)))
   zz <- runif(length(x))
   y <- ifelse(zz>0.5,"Yes","No")
}
df <- data.frame(Category=factor(x),Outcome=factor(y))
if(is.null(x)) {df$Category <- factor(df$Category,levels=c("Control",
                                           "Disturbed",
                                           "Caged",
                                           "Enriched"))
df$Outcome <- factor(df$Outcome,levels=c("Yes","No"))}

stats <- chisq.test(table(df$Category,df$Outcome),simulate.p.value = TRUE, B=10000)
p_val <- paste0("p = ", round(stats$p.value,digits=3),"\n"," (bootstrap with 10,000 randomizations)")
chi <- paste0("Chi-square = ",round(stats$statistic,digits=3), "; ")


figure_a <- ggplot2::ggplot(data=df) +
  ggmosaic::geom_mosaic(aes(x=product(Category),
                            fill=Outcome),
                            show.legend=FALSE,
                            offset=0.004) +
#  scale_fill_manual(values=c("darkgreen","grey70")) + 
theme_classic(base_size = 20,
              base_family="serif") +
theme(plot.subtitle = element_text(size = 15),
      axis.title.y = element_text(angle = 90, 
                                  vjust = 0.5)) + 
  labs(subtitle = paste0(chi,
                         p_val)) 


print(figure_a)

return()

} # end of function q_con2
# --------------------------------------
 # q_con2()
