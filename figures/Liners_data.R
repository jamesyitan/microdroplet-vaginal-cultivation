#read in data
datatable <- read.delim("droplet_tracker.txt",header=FALSE)
C0114 <- c(datatable[,1])
N0114 <- c(datatable[,2])
C0217 <- c(datatable[,3])
N0217 <- c(datatable[,4])
C0506 <- c(datatable[,5])
N0506 <- c(datatable[,6])
C0806 <- c(datatable[,7])
N0806 <- c(datatable[,8])
C0114pH4 <- c(datatable[,9])
C0217pH4 <- c(datatable[,10])

data_0114 <- list("CVF pH 4"=C0114pH4, "CVF pH 7" = C0114, "NYCIII pH 7" = N0114)
data_0217 <- list("CVF pH 4"=C0217pH4, "CVF pH 7" = C0217, "NYCIII pH 7" = N0217)
data_0506 <- list("CVF pH 7" = C0506, "NYCIII pH 7" = N0506)
data_0806 <- list("CVF pH 7" = C0806, "NYCIII pH 7" = N0806)

#make plots
vioplot(data_0114, main="1/14/2021", col="black", vertical = TRUE, method = "jitter", pch = 16, cex = 1.5, ylim=c(0,0.2),ylab="Biofilm area occupancy",cex.lab=1.2, cex.axis=1.2, cex.main=1.5)

#make plots
par(mfrow=c(1,4))
vioplot(data_0114, main="1/14/2021", col="black", vertical = TRUE, method = "jitter", pch = 16, cex = 1.5, ylim=c(0,0.2),ylab="Biofilm area occupancy",cex.lab=1.2, cex.axis=1.2, cex.main=1.5)
vioplot(data_0217, main="2/17/2021", col="black", vertical = TRUE, method = "jitter", pch = 16, cex = 1.5, ylim=c(0,0.3),ylab="Biofilm area occupancy",cex.lab=1.2, cex.axis=1.2, cex.main=1.5)
vioplot(data_0506, main="5/6/2021", col="black", vertical = TRUE, method = "jitter", pch = 16, cex = 1.5, ylim=c(0,0.3),ylab="Biofilm area occupancy",cex.lab=1.2, cex.axis=1.2, cex.main=1.5)
vioplot(data_0806, main="5/6/2021", col="black", vertical = TRUE, method = "jitter", pch = 16, cex = 1.5, ylim=c(0,0.3),ylab="Biofilm area occupancy",cex.lab=1.2, cex.axis=1.2, cex.main=1.5)

shapiro.test(N0114)
#with(data_0114, shapiro.test("CVF_pH4")) # p = 0.7129
#with(droplet_data, shapiro.test(K[group == "100 um"])) # p = 0.6425
#with(droplet_data, shapiro.test(K[group == "150 um"])) # p = 0.183

#calculate statiscal significance

ttest_C0114vsN0114 <- t.test(C0114, N0114, var.equal=FALSE) # p = 1.27E-9
ttest_C0114pH4vsC0114 <- t.test(C0114pH4, C0114, var.equal=FALSE) # p = 3.65E-36
ttest_C0114pH4vsN0114 <- t.test(C0114pH4, N0114, var.equal=FALSE) # p = 1.40E-31