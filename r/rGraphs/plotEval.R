#classifiers 
dat = rbind(noChange, naiveBayes, levBag, htADWIN, hTeddm, awe, aue)

#accuracy
acc <- ggplot(aes(x = learning.evaluation.instances, y = classifications.correct..percent., color = classifier, linetype = classifier), data = dat) +
  geom_line(lwd = 1) +
  theme_gdocs()+
  labs(y="Accuracy",x="Instances") +
  scale_color_gdocs() +
  scale_x_continuous(breaks = seq(0, 100000, 1500))+
  ggtitle("Classification accuracy")



#kappa statistic


k <- ggplot(aes(x = learning.evaluation.instances, y = Kappa.Statistic..percent., color = classifier, linetype = classifier), data = dat) +
  geom_line(lwd = 1) +
  theme_gdocs()+
  labs(y="Kappa",x="Instances") +
  scale_color_gdocs() +
  scale_x_continuous(breaks = seq(0, 100000, 1500))+
  ggtitle("Kappa statistic")

#kappa plus

kp <- ggplot(aes(x = learning.evaluation.instances, y = Kappa.Temporal.Statistic..percent., color = classifier, linetype = classifier), data = dat) +
  geom_line(lwd = 1) +
  theme_gdocs()+
  labs(y="Kappa plus",x="Instances") +
  scale_color_gdocs() +
  scale_x_continuous(breaks = seq(0, 100000, 1500))+
  ggtitle("Kappa plus statistic")

#multiplot(k,kp, cols=2)

grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 2)))
vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
print(acc, vp = vplayout(1, 1:2))  # key is to define vplayout
print(k, vp = vplayout(2, 1))
print(kp, vp = vplayout(2, 2))