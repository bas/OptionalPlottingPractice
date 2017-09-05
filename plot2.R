data <- read.csv("payments.csv", header = TRUE, quote = "\"", sep = ",")
medicalCondition <- as.vector(unique(data$DRG.Definition))
pdf("plot2.pdf", width = 8.3, height = 11.7)
m <- rbind(c(1, 1), c(2, 3), c(4,5), c(6,7))
layout(m)
par(mar=c(5.1,4.1,5.1,2.1))
plot(1, type = "n", axes=FALSE, xlab="", ylab="", main = "Relation between mean covered charges\nand mean total payments by medical condition")
legend("top", title = "Medical condition", legend = medicalCondition, fill = 1:7)
for (state in unique(data$Provider.State)) {
  d <- subset(data, Provider.State == state)
  d$Average.Covered.Charges <- d$Average.Covered.Charges/1000
  d$Average.Total.Payments <- d$Average.Total.Payments/1000
  plot(Average.Covered.Charges ~ Average.Total.Payments, data = d, col = DRG.Definition, xaxt="n", yaxt="n", ylab = "Mean covered charges", xlab = "Mean total payments", main = paste("State:", state))
  axis(2, at=axTicks(2), labels=sprintf("$%sK", axTicks(2)))
  axis(1, at=axTicks(1), labels=sprintf("$%sK", axTicks(1)))
  abline(lm(d$Average.Covered.Charges ~ d$Average.Total.Payments), col = "blue", lwd = 2)
}
dev.off()

