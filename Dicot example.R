# 9 APril 2024
# RKH 

dicot <-c(1,0,0,0,1) 
dicot==0
sum(dicot==0)
sum(dicot)

count <-0 
for (i in seq_along(dicot)) {
  count <- count + as.numeric(dicot[i]==0)
}
print(count)

