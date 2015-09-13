####
## Comparison of chunk sizes for awe and aue on elec2
####

#classifiers  

ggplot(aes(x = learning.evaluation.instances, y = classifications.correct..percent., color = classifier, linetype = classifier), data = dat) +
  geom_line(lwd = 1) +
  theme_gdocs()+
  labs(y="Accuracy",x="Instances") +
  scale_color_gdocs() +
  scale_x_continuous(breaks = seq(0, 100000, 1500))+
  ggtitle("Classification accuracy")
