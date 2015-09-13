#classifiers
#dat = rbind(levBag, htADWIN, hTeddm, hT, awe, aue)

dat = rbind(noChange, levBag, awe, aue, ensSAE, hT)
ggplot(aes(x = learning.evaluation.instances, y = classifications.correct..percent., color = classifier), data = dat) + geom_line()


#THe best simple classifiers 
dat = rbind(ensSAEmax, ensSAEmin, ensSAE, hT, naiveBayes)
ggplot(aes(x = learning.evaluation.instances, y = classifications.correct..percent., color = classifier, linetype = classifier), data = dat) +
  geom_line(lwd = 1) +
  theme_gdocs()+
  labs(y="Accuracy",x="Instances") +
  scale_color_gdocs() +
  scale_x_continuous(breaks = seq(0, 100000, 1500))

