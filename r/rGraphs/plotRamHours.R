#classifiers 
dat = rbind(noChange, naiveBayes, hT)

dat = rbind(ensSAE, ensSAEmax, ensSAEmin)
ggplot(aes(x = learning.evaluation.instances, y = model.cost..RAM.Hours., col = classifier, linetype = classifier), data = dat) + 
  geom_line(lwd = 1) +
  theme_gdocs()+
  labs(y="Ram-Hours",x="Instances") +
  scale_color_gdocs()


####
## Comparison of chunk sizes for awe and aue on elec2
####
#ram-hours 
dat = rbind(awe, aue, awe20, aue20)


ggplot(aes(x = learning.evaluation.instances, y = model.cost..RAM.Hours., col = classifier, linetype = classifier), data = dat) + 
  geom_line(lwd = 1) +
  theme_gdocs()+
  labs(y="Ram-Hours",x="Instances") +
  scale_color_gdocs()
