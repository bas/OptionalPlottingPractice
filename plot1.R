data <- read.csv("payments.csv", header = TRUE, quote = "\"", sep = ",")
nydata <- data[data$Provider.State == "NY",]
nydata$Average.Covered.Charges <- nydata$Average.Covered.Charges/1000
nydata$Average.Total.Payments <- nydata$Average.Total.Payments/1000
pdf("plot1.pdf")
plot(Average.Covered.Charges ~ Average.Total.Payments, data=nydata, ylab = "Mean covered charges", xlab = "Mean total payments", main = "Relation between mean covered charges\nand mean total payments in New York (NY)", xaxt="n", yaxt="n", col = rgb(0, 0, 0, 0.5), pch=16)
axis(2, at=axTicks(2), labels=sprintf("$%sK", axTicks(2)))
axis(1, at=axTicks(1), labels=sprintf("$%sK", axTicks(1)))
abline(lm(nydata$Average.Covered.Charges ~ nydata$Average.Total.Payments), col = "blue", lwd = 2)
dev.off()