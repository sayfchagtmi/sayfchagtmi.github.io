
###################################
#Importer les packages nécessaires#
###################################

library(ggplot2)
library(scales)
library(xlsx)

############################################
#Importer et préparer notre base de données#
############################################
set.seed(5)
data_100=read.table(file=file.choose(),header=TRUE,sep=";",dec="." ) 
attach(data_100)
names(data_100) = c('etudiant','sexe','situation','membre','plateforme','amis','appareil','nb_heures','temps','interêt')

y = matrix(100,1)

for(i in 1:100){
  if (data_100[i,8] == "Entre 0 et 1 heure")
    y[i]=0.5
  if (data_100[i,8] == "Entre 1 et 2 heures" )
    y[i]=1.5
  if (data_100[i,8] == "Entre 2 et 3 heures" )
    y[i]=2.5
  if (data_100[i,8] == "Entre 3 et 4 heures" )
    y[i]=3.5
  if (data_100[i,8] == "Plus de 4 heures" )
    y[i]=4.5
}

a = matrix(100,1)

for(i in 1:100){
  if (data_100[i,6] == "Moins de 100")
    a[i] = 50
  if (data_100[i,6] == "Entre 100 et 500")
    a[i] = 300
  if (data_100[i,6] == "Entre 500 et 1000")
    a[i] = 750
  if (data_100[i,6] == "Plus de 1000")
    a[i] = 1250
}

data_100 = cbind(data_100,y,a)

#######################################################################
#Calculer les pourcentages de la répartion selon la variable d'interêt#
#######################################################################

ylabels = c(sum(y == 4.5),sum(y == 3.5),sum(y == 2.5),sum(y == 1.5),sum(y == 0.5))
ylabels = sprintf("%d%s",ylabels,"%")

#########################################
#Répartition selon la Vairable d'interêt#
#########################################

py = ggplot(data_100,aes(x="",fill=factor(nb_heures)))+coord_polar(theta="y")+ geom_bar(width = 1)  +labs(x="",y="",fill="nb_heures") +scale_fill_brewer("",palette="Set2")+ggtitle("La repartition de la population selon la variable d'interet : \n Nombre des heures") +annotate("text",label= ylabels,x=c(1,1,1,1,1.44),y=c(25,55,75,89,99),size=3)
py

mean(y)
###########################
#Répartition des étudiants#
###########################

elabels = c(sum(etudiant == "Oui"),sum(etudiant == "Non"))
elabels = sprintf("%d%s",elabels,"%")

pe = ggplot(data_100,aes(x="",fill=factor(etudiant)))+coord_polar(theta="y")+ geom_bar(width = 1)  +labs(x="",y="",fill="etudiant") +scale_fill_brewer("",palette="Set2")+ggtitle("La repartition de la population selon la variable d'interet : \n Etudiant") +annotate("text",label= elabels,x=c(1,1.3),y=c(50,96),size=6)
pe


be =  ggplot(data_100,aes(x=factor(etudiant),fill=factor(nb_heures)))+geom_bar(width = 1)  +labs(x="",y="",fill="Nombre d'heures")
be

##########################
#Répartiton selon le Sexe#
##########################

slabels = c(sum(sexe == "Homme"),sum(sexe == "Femme"))
slabels = sprintf("%d%s",slabels,"%")

ps = ggplot(data_100,aes(x="",fill=factor(sexe)))+coord_polar(theta="y")+ geom_bar(width = 1)  +labs(x="",y="",fill="Sexe") +scale_fill_brewer("",palette="Set2")+ggtitle("La repartition de la population selon le : \n Sexe") +annotate("text",label= slabels,x=c(1,1),y=c(20,70),size=6)
ps


bs =  ggplot(data_100,aes(x=factor(sexe),fill=factor(nb_heures)))+geom_bar(width = 1)  +labs(x="",y="",fill="Nombre d'heures")
bs

################################
#Répartition selon l'état civil#
################################

silabels = c(sum(situation == "Un_coeur_a_prendre"),sum(situation == "Marie(e)"),sum(situation == "En couple"))
silabels = sprintf("%d%s",silabels,"%")

psi = ggplot(data_100,aes(x="",fill=factor(situation)))+coord_polar(theta="y")+ geom_bar(width = 1)  +labs(x="",y="",fill="Etat Civil") +scale_fill_brewer("",palette="Set2")+ggtitle("La repartition de la population selon : \n l'Etat Civil") +annotate("text",label= silabels,x=c(1,1.4,1),y=c(40,70,85),size=3)
psi


bsi =  ggplot(data_100,aes(x=factor(situation),fill=factor(nb_heures)))+geom_bar(width = 1)  +labs(x="",y="",fill="Nombre d'heures")
bsi

###############################
#Répartion selon la plateforme#
###############################

plabels = c(sum(situation == "youtube"),sum(situation == "Twitter"),sum(situation == "Linkedin"),sum(plateforme == "Instagram / Snapchat"),sum(plateforme == "Facebook"))
plabels = sprintf("%d%s",plabels,"%")

pp = ggplot(data_100,aes(x="",fill=factor(plateforme)))+coord_polar(theta="y")+ geom_bar(width = 1)  +labs(x="",y="",fill="Plateforme") +scale_fill_brewer("",palette="Set2")+ggtitle("La repartition de la population selon : \n la Plateforme") +annotate("text",label= plabels,x=c(1.4,1.3,1.4,1,1),y=c(1.5,2.5,3.5,10,60),size=3)
pp


bp =  ggplot(data_100,aes(x=factor(plateforme),fill=factor(nb_heures)))+geom_bar(width = 1)  +labs(x="",y="",fill="Nombre d'heures")
bp

################################
#Répartition selon les contacts#
################################

clabels = c(sum(amis == "Plus de 1000"),sum(amis == "Moins de 100"),sum(amis == "Entre 500 et 1000"),sum(amis == "Entre 100 et 500"))
clabels = sprintf("%d%s",clabels,"%")

pc = ggplot(data_100,aes(x="",fill=factor(amis)))+coord_polar(theta="y")+ geom_bar(width = 1)  +labs(x="",y="",fill="Les amis") +scale_fill_brewer("",palette="Set2")+ggtitle("La repartition de la population selon : \n amis") +annotate("text",label= clabels,x=c(1,1.4,1,1),y=c(15,30.5,50,85),size=3)
pc

bc =  ggplot(data_100,aes(x=factor(amis),fill=factor(nb_heures)))+geom_bar(width = 1)  +labs(x="",y="",fill="Nombre d'heures")
bc

##############################
#Répartition selon l'appareil#
##############################

aplabels = c(sum(appareil == "Smartphone"),sum(appareil == "Ordinateur portable / tablette"),sum(appareil == "Ordinateur bureautique"))
aplabels = sprintf("%d%s",aplabels,"%")

pap = ggplot(data_100,aes(x="",fill=factor(appareil)))+coord_polar(theta="y")+ geom_bar(width = 1)  +labs(x="",y="",fill="Les appareils") +scale_fill_brewer("",palette="Set2")+ggtitle("La repartition de la population selon : \n l'appareil") +annotate("text",label= aplabels,x=c(1,1,1.4),y=c(40,90,99.9),size=3)
pap


bap =  ggplot(data_100,aes(x=factor(appareil),fill=factor(nb_heures)))+geom_bar(width = 1)  +labs(x="",y="",fill="Nombre d'heures")
bap

#############################
#Répartition selon le temps #
#############################

tlabels = c(sum(temps == "Le matin avant 8 :00"),sum(temps == "De 8 :00 Ã  17 :00"),sum(temps == "A partir de 17 :00"))
tlabels = sprintf("%d%s",tlabels,"%")

pt = ggplot(data_100,aes(x="",fill=factor(temps)))+coord_polar(theta="y")+ geom_bar(width = 1)  +labs(x="",y="",fill="Le temps") +scale_fill_brewer("",palette="Set2")+ggtitle("La repartition de la population selon : \n le temps") +annotate("text",label= tlabels,x=c(1.3,1,1),y=c(1.5,9,65),size=3)
pt


bt =  ggplot(data_100,aes(x=factor(temps),fill=factor(nb_heures)))+geom_bar(width = 1)  +labs(x="",y="",fill="Nombre d'heures")
bt

#############################
#Répartition selon l'interêt#
#############################

ilabels = c(sum(interêt == "Voyages / mode"),sum(interêt == "Tous"),sum(interêt == "Television / films"),sum(interêt == "Sante / sport"),sum(interêt == "Nourriture"),sum(interêt == "Art / musique"),sum(interêt == "Actualite"))
ilabels = sprintf("%d%s",ilabels,"%")

pi = ggplot(data_100,aes(x="",fill=factor(interêt)))+coord_polar(theta="y")+ geom_bar(width = 1)  +labs(x="",y="",fill="L'es amis'interêt") +scale_fill_brewer("",palette="Set2")+ggtitle("La repartition de la population selon : \n l'interêt") +annotate("text",label= ilabels,x=c(1,1.4,1,1,1.3,1,1.4),y=c(13,26,40,55,68,83,98),size=3)
pi


bi =  ggplot(data_100,aes(x=factor(interêt),fill=factor(nb_heures)))+geom_bar(width = 1)  +labs(x="",y="",fill="Nombre d'heures")
bi




##################
#SAS PESR et PEAR#
##################

set.seed(5)

################################################# PESR

N=100

mu=mean(y) 
sigma2c=var(y) 
var=((N-1)/N)*sigma2c 
T=sum(y)

n=20
tirage=function(y){
  echantillon=sample(y,n,replace=F) 
  ybarpesr=mean(echantillon) 
  varybarpesr=var*(1-(n/N))/n
  sc2=var(echantillon)
  s2=((n-1)/n)*sc2
  varestimybarpesr=s2*(1-(n/N))/n 
  v=c(echantillon,ybarpesr,varybarpesr,varestimybarpesr) 
  return(v)
}

res=replicate(20,tirage(y)) 
View(res)

ICbinf=1:20
ICbsup=1:20 
longueur=1:20
for (i in 1:20) {
  ICbinf[i]=res[21,i]-1.729*sqrt(res[23,i])# 1.729 :c'est le quantile de student avec alpha=0.05 et degre de liberte=19
  ICbsup[i]=res[21,i]+1.729*sqrt(res[23,i])
  
  mu[i]=res[21,i]
  longueur[i]=ICbsup[i]-ICbinf[i] }
mean(longueur)
mu1=mean(mu)
res=data.frame(res)
res=t(res)
res_pesr=NULL 
res_pesr=data.frame(y=1:20,res[,21],res[,22],res[,23],ICbinf,ICbsup,longueur)
p1_pesr=ggplot(res_pesr,aes(y,ICbsup))+geom_point(colour="red",cex=2)+geom_point(aes(y,ICbinf) ,colour="darkblue",cex=2)+geom_path(colour="red",size=1)+geom_path(aes(y,ICbinf),colour="darkb lue",size=1)
p2_pesr=annotate("text", label =c("La borne inferieure","La borne superieure"), x =c(3,3), y =c(1,1.25),size =5, colour =c("darkblue","red"))
p3_pesr=labs(x="",y="")
p1_pesr+p2_pesr+p3_pesr+ggtitle("les 20 intervalles de confiance : PESR")+theme(plot.title = element_text(color="black",size=14, face="bold.italic"))
res_pesr=res_pesr[-1]
colnames(res_pesr)=c("ybar_chapeau_pesr","var_ybar_chapeau_pesr","var_estim_ybar_chapeau_pesr ","ICbinf_pesr","ICbsup_pesr","long_IC_pesr")
rownames(res_pesr)=c(1:20)
View(res_pesr)
View(res)
mean(res_pesr$ybar_chapeau_pesr)




#####Pear  

tirage=function(y){
  echantillon=sample(y,n,replace=T) 
  ybarpear=mean(echantillon)
  varybarpear=sigma2c/n
  sc2=var(echantillon)
  s2=((n-1)/n)*sc2
  varestimybarpear=s2/n 
  v=c(echantillon,ybarpear,varybarpear,varestimybarpear) 
  return(v)
} 

res=replicate(20,tirage(y)) 
res
ICbinf=1:20
ICbsup=1:20 
longueur=1:20

for (i in 1:20) {
  ICbinf[i]=res[21,i]-1.729*sqrt(res[23,i])#1.729:quantile de student avec alpha=0.05% et degre de liberte=19
  ICbsup[i]=res[21,i]+1.729*sqrt(res[23,i]) 
  
  mu[i]=res[21,i] 
  longueur[i]=ICbsup[i]-ICbinf[i]
}

longueur 
mean(longueur) 
mu1=mean(mu) 
mu1 
res=data.frame(res) 
res=t(res)

res_pear=NULL 
res_pear=data.frame(y=1:20,res[,21],res[,22],res[,23],ICbinf,ICbsup,longueur)
p1_pear=ggplot(res_pear,aes(y,ICbsup))+geom_point(colour="red",cex=2)+geom_point(aes(y,ICbinf) ,colour="darkblue",cex=2)+
  geom_path(colour="red",size=1)+geom_path(aes(y,ICbinf),colour="darkblue",size=1)
p2_pear=annotate("text", label =c("La borne inferieure","La borne superieure"), x =c(3,3), y =c(1,1.5),size =5, colour =c("darkblue","red"))
p3_pear=labs(x="",y="")
p1_pear+p2_pear+ggtitle("les 20 intervalles de confiance : PEAR")+theme(plot.title = element_text(color="black",size=14, face="bold.italic"))
res_pear=res_pear[-1]
colnames(res_pear)=c("ybar_chapeau_pear","var_ybar_chapeau_pear","var_estim_ybar_chapeau_pea r","ICbinf_PEAR","ICbsup_PEAR","long_IC_PEAR")
View(res_pear) 
rownames(res_pear)=c(1:20)
mean(res_pear$ybar_chapeau_pear)



################################################### proba inegales 

x=matrix(100,1)

for (i in 1:100) {x[i] = a[i]}
View(x)
data_100=cbind(data,100) 
View(data_100)


summary(data_100)
library(sampling)

pic = inclusionprobabilities(x,20)#calculer les probabilites d'inclusion sum(pic)
pic

pk=rep(0,length(x))
vk=rep(0,length(x))
for(i in 1:N){
  pk[i]=(x[i])/sum(x) }
pk
sum(pk) 
vk[1]=pk[1]
for(i in 2:length(x)){
  vk[i]=vk[i-1]+pk[i] }
vk 
pvk=cbind(pk,vk) 
pvk

f=function(res){
  xipi=rep(0,20) 
  xipi1=rep(0,20) 
  xipi2=rep(0,20)
  sumxipi=0
  sumxipi1=0 
  res=matrix(nrow=20,ncol=4)
  
  
  
  for(i in 1:20){
    u=runif(1,0,1)
    if(0<u&&u<vk[1]){ res[i,]=c(1,0,u,vk[1])
    }
    for(j in 2:100){
      if(vk[j-1]<u&&u<vk[j]){ (res[i,]=c(j,vk[j-1],u,vk[j]))
      }
    }
  }
  
  ##########PIAR  
  for(i in 1:20){ xipi[i]=y[res[i,1]]/pk[res[i,1]] 
  } 
  sumxipi=sum(xipi) 
  T_HH=sumxipi/n 
  ybarpiar=T_HH/N
  for(i in 1:100){ xipi1[i]=(((y[i]/pk[i])-T)^2)*pk[i]
  }
  sumxipi1=sum(xipi1) 
  varybarpiar=sum(xipi1)/(n*(N^2))
  
  for(i in 1:20){ xipi2[i]=((y[res[i,1]]/pk[res[i,1]])-(N*ybarpiar))^2
  } 
  varestimybarpiar=sum(xipi2)/(n*(n-1)*(N^2))
  v=c(res[,1],ybarpiar,varybarpiar,varestimybarpiar)
  return(v) 
}
res1=replicate(20,f(res)) 
res1
ICbinf=1:20 
ICbsup=1:20 
longueur=1:20
for (i in 1:20) { 
  ICbinf[i]=res1[21,i]-1.729*sqrt(res1[23,i]) 
  ICbsup[i]=res1[21,i]+1.729*sqrt(res1[23,i]) 
  mu[i]=res1[21,i] 
  longueur[i]=ICbsup[i]-ICbinf[i]}
longueur 
mean(longueur) 
mu1=mean(mu) 
View(res1)
echan=res1[1:20,]
colnames(echan)=c("ech1","ech2","ech3","ech4","ech5","ech6","ech7","ech8","ech9","ech10","ech11 ","ech12","ech13","ech14","ech15","ech16","ech17","ech18","ech19","ech20") 
View(echan)
ress=res1[21:23,]
ress=t(ress)
colnames(ress)=c("y_bar_piar","var_ybar_piar","var_est") 
ress=data.frame(y=1:20,ress[,1],ress[,2],ress[,3],ICbinf,ICbsup,longueur)
g1_piar=ggplot(ress,aes(y,ICbsup))+geom_point(colour="red",cex=4)+geom_point(aes(y,ICbinf),colour="darkblue",cex=4)+geom_path(colour="red",size=1)+geom_path(aes(y,ICbinf),colour="darkblue", size=1)
g2_piar=annotate("text", label =c("La borne inferieure","La borne superieure"), x =c(3,3), y =c(1,1.5),size =5, colour =c("darkblue","red"))
g3_piar=labs(x="",y="")
g1_piar+g2_piar+g3_piar+ggtitle("les 20 intervalles de confiance : PIAR")+theme(plot.title = element_text(color="black",size=14, face="bold.italic"))
ress=ress[-1]
colnames(ress)=c("ybar_chapeau_piar","var_ybar_chapeau_piar","var_estim_ybar_chapeau_piar","IC binf_PIAR","ICbsup_PIAR","long_IC_
                 PIAR") 
View(ress)

####################################################### pisr
set.seed(5)
s=sum(x)
g=function(r){
  f=function(result){
    res=matrix(nrow=20,ncol=4)
    p=1
    q=5
    
    
    #on tire 1 individu dans chaque groupe
    for (i in 1:20){
      pk=rep(0,5)
      vk=rep(0,5)
      xn=rep(0,5)
      Trhc=0
      Tgpi=rep(0,20)
      
      #les 5 variables x dans le groupe i
      j=1
      for(k in p:q){
        xn[j]=x[k]
        j=j+1
      }
      
      #les probabilites d'inclusion dans le groupe i
      j=1
      for(k in p:q){
        pk[j]=(x[k])/sum(xn)
        j=j+1
      }
      
      vk[1]=pk[1]
      for(k in 2:5){
        vk[k]=vk[k-1]+pk[k]
      }
      
      
      #on tire 1 individu de le groupe i
      u=runif(1,0,1)
      if(0<u&&u<vk[1]){ res[i,]=c(p,0,u,vk[1])}
      for(j in 2:5){
        if(vk[j-1]<u&&u<vk[j]){
          (res[i,]=c(p+j-1,vk[j-1],u,vk[j]))
        }
      }
      
      
      q=q+5
      p=p+5
    }
    
    p=1
    for (i in 1:20){
      Tg=rep(0,5)
      for (k in 1:5){
        Tg[k]=x[p+k-1]*(y[res[i,1]]/x[res[i,1]])
        
      }
      Tgpi[i]=sum(Tg)
      p=p+5
      
    }
    result=cbind(res[,1],Tgpi)
    return(result)
    
    
  }
  
  #L'estimateur Horvitz Thompson
  T_rhc=sum((f(result))[,2])
  #la moyenne
  y_bar_pisr=T_rhc/100
  
  p=1
  xg=rep(0,20)
  xig=rep(0,5)
  for (i in 1:20){
    for (k in 1:5){
      xig[k]=x[p+k-1]
    }
    xg[i]=sum(xig)
    p=p+5
    
  }
  
  s1=rep(0,20)
  for (i in 1:20) {
    s1[i]=s*(xg[i]*((y[(f(result))[i,1]]/x[(f(result))[i,1]])^2))
    
  }
  
  som=sum(s1)
  
  #la variance estimee
  var_estim_y_pisr=abs((((1-(n/N))/(n*(n-1)))*(som-(T_rhc^2)))*(n/(N^2)))
  
  r=c((f(result))[,1],y_bar_pisr,var_estim_y_pisr)
  return(r)
}
g(r)
#on repete le tirage 20 fois
res2=replicate(20,g(r),set.seed(5))
res2
#les intervalles de confiance
ICbinf=1:20
ICbsup=1:20
longueur=1:20
for (i in 1:20) {
  ICbinf[i]=res2[21,i]-1.729*sqrt(res2[22,i])
  ICbsup[i]=res2[21,i]+1.729*sqrt(res2[22,i])
  mu[i]=res2[21,i]
  longueur[i]=ICbsup[i]-ICbinf[i]
}
tt=data.frame(y=1:20,ICbinf,ICbsup,longueur)
t=ggplot(tt,aes(y,ICbsup))+geom_point(colour="red",cex=4)+geom_point(aes(y,ICbinf),colour="darkblue",cex=4)+geom_path(colour="red",size=1)+geom_path(aes(y,ICbinf),colour="darkblue",size=1)
t1=annotate("text", label =c("La borne inferieure","La borne superieure"), x =c(17,17), y=c(0.5,1),size =5, colour = c("darkblue","red"))
t2=labs(x="",y="")

t+t1+t2+ggtitle("les 20 intervalles de confiance : PISR")+theme(plot.title =element_text(color="black", size=14,face="bold.italic"))
longueur#les longueurs des intervalles de confiance
mean(longueur)#la moyenne des longueurs
mu#y_bar_pisr dans chaque echantillon
mu1=mean(mu)
mu1#la moyenne des y_bar_pisr
ech=res2[1:20,]
colnames(ech)=c("ech1","ech2","ech3","ech4","ech5","ech6","ech7","ech8","ech9","ech10","ech11","
                ech12","ech13","ech
                14","ech15","ech16","ech17","ech18","ech19","ech20")
View(ech)
tt=cbind(res2[21,],res2[22,],tt[,-1])
colnames(tt)=c("y_bar_chapeau_pisr","var_est_ybar_chapeau","Icbinf_pisr","ICbsup_pisr","long_IC_
               pisr")
View(tt)


#########################################
##############Straification##############
#########################################

########################
#Definition des strates#
########################

N=100
n=20
h=3
Nh=as.vector(table(data_100$amis))
Nh
strate1=rep(0,Nh[1]) #Entre 100 et 500
j=1
for (i in 1:100) {
  if(data_100$amis[i]=="Entre 100 et 500") {strate1[j]=y[i]; j=j+1;}
}
strate1
strate2=rep(0,Nh[2]) #Entre 500 et 1000
j=1
for (i in 1:100) {
  if(data_100$amis[i]=="Entre 500 et 1000" || data_100$amis[i]=="Moins de 100") {strate2[j]=y[i]; j=j+1;}
}
strate2
strate3=rep(0,Nh[3]) #Plus de 1000
j=1
for (i in 1:100) {
  if(data_100$amis[i]=="Plus de 1000") {strate3[j]=y[i]; j=j+1;}
}
strate3

strates=list(strate1,strate2,strate3)
strates

#############################
#Propriétés de chaque strate#
#############################

sigma2_hc=NULL
sigma2_h=NULL
ybar_strates=NULL
for (i in 1:h){
  ybar_strates[i]=list(mean(unlist(strates[i])))
  ybar_strates=as.vector(unlist(ybar_strates))
  ybar_strates
  sigma2_hc[i]=var(unlist(strates[i]))
  sigma2_h[i]=((N-1)/N)*sigma2_hc[i]}
sigma2_hc
sigma2_h
ybar_strates
setNames(sigma2_hc,sigma2_h,ybar_strates)
t=data.frame("Strate 1" = c(ybar_strates[1],sigma2_h[1],sigma2_hc[1]),"Strate 2" = c(ybar_strates[2],sigma2_h[2],sigma2_hc[2]),"Strate 3" = c(ybar_strates[3],sigma2_h[3],sigma2_hc[3]))

row.names(t) = c("Moyenne","Variance","Variance corrigée")
t

################################
#Les strates ont la même taille#
################################

nh=c(rep(round(n/h),h)) #Calcul des nh
nh

#############################################
#Tirage de 20 echantillons et calcul demandé#
#############################################
### Calcul des nh 
nh=c(rep(round(n/h),h)) 
nh 

##############################################
#Tirage de 20 echantillons et calcul demandé #
##############################################

res_strat=matrix(0,20,7) 
for (k in 1:20){ 
  
  #ybar_ech et var_ech 
  ech1=sample(strate1,nh[1],replace=FALSE) 
  ech1 
  ybar_hat1=mean(ech1) 
  s2_c_h1=var(ech1) 
  ech2=sample(strate2,nh[2],replace=FALSE) 
  ech2 
  ybar_hat2=mean(ech2) 
  s2_c_h2=var(ech2) 
  ech3=sample(strate3,nh[3],replace=FALSE) 
  ech3 
  ybar_hat3=mean(ech3) 
  s2_c_h3=var(ech3) 
  # ybar estimée pour chaque strate 
  ybar_hat_strates=c(ybar_hat1,ybar_hat2,ybar_hat3) 
  ybar_hat_strates 
  
  # ybar estimée 
  ybar_hat=(1/N)*sum(Nh*ybar_hat_strates) 
  ybar_hat 
  mean(y) 
  # variances corrigées de l'echantillon dans chaque strate 
  s2_hc=c(s2_c_h1,s2_c_h2,s2_c_h3) 
  
  # Variance totale - Variance intra strates - variance inter strates 
  
  fh=NULL 
  for(i in 1:h){ 
    fh[i]=nh[i]/Nh[i] 
    
  } 
  var_ybar_hat_strat=(1/N^2)*(sum(((Nh^2)/nh)*(1-fh)*sigma2_hc)) 
  var_inter_y=(1/N)*sum(Nh*(ybar_strates-mean(y))^2) 
  var_intra_y=(1/N)*sum(Nh*sigma2_h) 
  var_inter_y+var_intra_y 
  var_y=((N-1)/N)*var(y) 
  
  #variance estimée 
  var_estim_ybar_hat_strat=(1/N^2)*(sum(((Nh^2)/nh)*(1-fh)*s2_hc)) 
  var_y=((N-1)/N)*var(y) 
  ## les intervalles de confiance 
  ic_inf_strat=NULL 
  ic_sup_strat=NULL 
  interval_strat=NULL 
  long_ic=NULL 
  
  
  ic_inf_strat=ybar_hat-1.96*var_estim_ybar_hat_strat 
  ic_sup_strat=ybar_hat+1.96*var_estim_ybar_hat_strat 
  long_ic=ic_sup_strat-ic_inf_strat 
  
  
  res_strat[k,]=c(ybar_hat,var_ybar_hat_strat, 
                  var_estim_ybar_hat_strat,var_intra_y, 
                  ic_inf_strat,ic_sup_strat,long_ic) 
} 

############################################################
# Resultats du sondage stratifié regroupés dans un tableau #
############################################################

res_strat 
colnames(res_strat)=c("ybar_hat","var_ybar_hat_strat","var_estim_ybar_hat_strat", 
                      "var_intra_strat","ic_inf_strat","ic_sup_strat" 
                      ,"long_ic_strat") 
### La moyenne de ybar estimées 
ybar_strat=mean(res_strat[,1]) 
ybar_strat 
### Moyenne des longueurs des intervalles de confiance 
long_strat=mean(res_strat[,7]) 
long_strat 
### Représentation de l'intervalles de confiance pour chacune des 20 expériences sur le même graphe 
res_s=NULL 
res_s=data.frame(y=1:20,res_strat[,1],res_strat[,2],res_strat[,3],res_strat[,4],res_strat[,5],res_strat[,6],res_strat[,7]) 
g1_s=ggplot(res_s,aes(y,res_strat[,6]))+geom_point(colour="red",cex=4)+geom_point(aes(y,res_strat[,5]),colour="black",cex=4)+geom_path(colour="red",size=1)+geom_path(aes(y,res_strat[,5]),colour="red",size=1) 
g2_s=annotate("text", label =c("La borne inférieure","La borne supérieure"), x =c(3,3), y =c(2,2.5),size =5, colour = c("red","black")) 
g3_s=labs(x="",y="") 
g1_s+g2_s+g3_s+ggtitle("les 20 intervalles de confiance \n Strates ont meme taille")+theme(plot.title = element_text(color="black", size=14, face="bold.italic")) 
res_strat=res_strat[,-4] 
View(res_strat) 
###############################################
#Les strates sont à allocation proportionnelle#
###############################################

nh=round(Nh*0.2) 
nh 
nh=nh[c(-3)]
### Tirage de 20 echantillons et calcul demandé 
res=matrix(0,20,7) 
res_prop=matrix(0,20,7) 
for (k in 1:20){ 
  ### 
  #ybar_ech et var_ech 
  ech1=sample(strate1,nh[1],replace=FALSE) 
  ech1 
  ybar_hat1=mean(ech1) 
  s2_c_h1=var(ech1) 
  ech2=sample(strate2,nh[2],replace=FALSE) 
  ech2 
  ybar_hat2=mean(ech2) 
  s2_c_h2=var(ech2) 
  
  ech3=sample(strate3,nh[3],replace=FALSE) 
  ech3 
  ybar_hat3=mean(ech3) 
  s2_c_h3=var(ech3) 
  # ybar estimée pour chaque strate 
  ybar_hat_strates=c(ybar_hat1,ybar_hat2,ybar_hat3) 
  ybar_hat_strates 
  
  # ybar estimée 
  ybar_hat=(1/N)*sum(Nh*ybar_hat_strates) 
  ybar_hat 
  mean(y) 
  # variances corrigées de l'echantillon dans chaque strate 
  s2_hc=c(s2_c_h1,s2_c_h2,s2_c_h3) 
  
  # Variance totale - Variance intra strates - variance inter strates 
  
  fh=NULL 
  for(i in 1:h){ 
    fh[i]=nh[i]/Nh[i] 
    
  } 
  var_ybar_hat_strat=(1/N^2)*(sum(((Nh^2)/nh)*(1-fh)*sigma2_hc)) 
  var_inter_y=(1/N)*sum(Nh*(ybar_strates-mean(y))^2) 
  var_intra_y=(1/N)*sum(Nh*sigma2_h) 
  var_inter_y+var_intra_y 
  var_y=((N-1)/N)*var(y) 
  
  #variance estimée 
  var_estim_ybar_hat_strat=(1/N^2)*(sum(((Nh^2)/nh)*(1-fh)*s2_hc)) 
  var_y=((N-1)/N)*var(y) 
  ## les intervalles de confiance 
  ic_inf_strat=NULL 
  ic_sup_strat=NULL 
  interval_strat=NULL 
  long_ic=NULL 
  
  
  ic_inf_strat=ybar_hat-1.729*var_estim_ybar_hat_strat 
  ic_sup_strat=ybar_hat+1.729*var_estim_ybar_hat_strat 
  
  long_ic=ic_sup_strat-ic_inf_strat 
  
  
  res_prop[k,]=c(ybar_hat,var_ybar_hat_strat, 
                 var_estim_ybar_hat_strat,var_intra_y, 
                 ic_inf_strat,ic_sup_strat,long_ic) 
} 
### Resultats du sondage stratifié regroupés dans un tableau 
res_prop 
colnames(res_prop)=c("ybar_hat","var_ybar_hat_prop","var_estim_ybar_hat_strat", 
                     "var_intra_strat","ic_inf_prop","ic_sup_prop" 
                     ,"long_ic_prop") 
### La moyenne de ybar estimées 
ybar_prop=mean(res_prop[,1]) 
ybar_prop 
### Moyenne des longueurs des intervalles de confiance 
long_prop=mean(res_prop[,7]) 
### Représentation de l'intervalles de confiance pour chacune des 20 expériences sur le même graphe 
res_prop1=NULL 
res_prop1=data.frame(y=1:20,res_prop[,1],res_prop[,2],res_prop[,3],res_prop[,4],res_prop[,5],res_prop[,6],res_prop[,7]) 
g1_prop=ggplot(res_prop1,aes(y,res_prop[,6]))+geom_point(colour="red",cex=4)+geom_point(aes(y,res_prop[,5]),colour="red",cex=4)+geom_path(colour="red",size=1)+geom_path(aes(y,res_prop[,5]),colour="red",size=1) 
g2_prop=annotate("text", label =c("La borne inférieure","La borne supérieure"), x =c(3,3), y =c(3,4.5),size =5, colour = c("red","black")) 
g3_prop=labs(x="",y="") 
g1_prop+g2_prop+g3_prop+ggtitle("les 20 intervalles de confiance \n Strates à allocation proportionelle")+theme(plot.title = element_text(color="black", size=14, face="bold.italic")) 
res_prop=res_prop[,-4] 
View(res_prop) 

########################################
#Les strates sont à allocation optimale#
########################################

nh=round(((n*Nh*(sigma2_hc)^0.5))/sum((Nh*(sigma2_hc)^0.5)) ) 
nh 
nh=nh[c(-3)]
### Tirage de 20 echantillons et calcul demandé 
res_opt=matrix(0,20,7) 
for (k in 1:20){ 
  ### 
  #ybar_ech et var_ech 
  ech1=sample(strate1,nh[1],replace=FALSE) 
  ech1 
  ybar_hat1=mean(ech1) 
  s2_c_h1=var(ech1) 
  ech2=sample(strate2,nh[2],replace=FALSE) 
  ech2 
  ybar_hat2=mean(ech2) 
  s2_c_h2=var(ech2) 
  
  ech3=sample(strate3,nh[3],replace=FALSE) 
  ech3 
  ybar_hat3=mean(ech3) 
  s2_c_h3=0 
  # ybar estimée pour chaque strate 
  ybar_hat_strates=c(ybar_hat1,ybar_hat2,ybar_hat3) 
  ybar_hat_strates 
  
  # ybar estimée 
  ybar_hat=(1/N)*sum(Nh*ybar_hat_strates) 
  ybar_hat 
  mean(y) 
  # variances corrigées de l'echantillon dans chaque strate 
  s2_hc=c(s2_c_h1,s2_c_h2,s2_c_h3) 
  
  # Variance totale de ybar_hat - Variance intra strates - variance inter strates 
  
  fh=NULL 
  for(i in 1:h){ 
    fh[i]=nh[i]/Nh[i] 
    
  } 
  var_ybar_hat_opt=(1/N^2)*(sum(((Nh^2)/nh)*(1-fh)*sigma2_hc)) 
  var_inter_y=(1/N)*sum(Nh*(ybar_strates-mean(y))^2) 
  var_intra_y=(1/N)*sum(Nh*sigma2_h) 
  var_inter_y+var_intra_y 
  var_y=((N-1)/N)*var(y) 
  
  #variance estimée 
  var_estim_ybar_hat_opt=(1/N^2)*(sum(((Nh^2)/nh)*(1-fh)*s2_hc)) 
  var_y=((N-1)/N)*var(y) 
  ## les intervalles de confiance 
  ic_inf_opt=NULL 
  ic_sup_opt=NULL 
  
  long_ic_opt=NULL 
  
  
  ic_inf_opt=ybar_hat-1.729*var_estim_ybar_hat_opt 
  ic_sup_opt=ybar_hat+1.729*var_estim_ybar_hat_opt 
  
  long_ic_opt=ic_sup_opt-ic_inf_opt 
  
  
  res_opt[k,]=c(ybar_hat,var_ybar_hat_strat, 
                var_estim_ybar_hat_opt,var_intra_y, 
                ic_inf_opt,ic_sup_opt,long_ic_opt) 
} 
### Resultats du sondage stratifié regroupés dans un tableau 
colnames(res_opt)=c("ybar_hat","var_ybar_hat_opt","var_estim_ybar_hat_opt", 
                    "var_intra_strat","ic_inf_strat","ic_sup_strat" 
                    ,"long_ic") 
### La moyenne de ybar estimées 
ybar_opt=mean(res_opt[,1]) 
ybar_opt 
### Moyenne des longueurs des intervalles de confiance 
long_opt=mean(res_opt[,7]) 
### Représentation de l'intervalles de confiance pour chacune des 20 expériences sur le même graphe 
res_opt1=NULL 
res_opt1=data.frame(y=1:20,res_opt[,1],res_opt[,2],res_opt[,3],res_opt[,4],res_opt[,5],res_opt[,6],res_opt[,7]) 
g1_opt=ggplot(res_opt1,aes(y,res_opt[,6]))+geom_point(colour="#000033",cex=4)+geom_point(aes(y,res_opt[,5]),colour=" red",cex=4)+geom_path(colour="#000033",size=1)+geom_path(aes(y,res_opt[,5]),colour="#99CC66",size=1) 
g2_opt=annotate("text", label =c("La borne inférieure","La borne supérieure"), x =c(3,3), y =c(3,4.5),size =5, colour = c("red","#000033")) 
g3_opt=labs(x="",y="") 
g1_opt+g2_opt+g3_opt+ggtitle("les 20 intervalles de confiance \n Strates à allocation optimale")+theme(plot.title = element_text(color="black", size=14, face="bold.italic")) 
res_opt=res_opt[,-4] 
View(res_opt) 
ybar_strat 
long_strat 
ybar_prop 
long_prop 
ybar_opt 
long_opt

########################
###Grappe###############
########################

grappe=matrix(0,100,1) 
for (i in 1:100) { 
  (if(data_100[i,10]=="Art / musique") (grappe[i]=1))
  (if(data_100[i,10]=="Tous") (grappe[i]=1))
  (if(data_100[i,10]=="Sante / sport") (grappe[i]=2)) 
  (if(data_100[i,10]=="Nourriture") (grappe[i]=2))
  (if (data_100[i,10]=="Television / films" ) (grappe[i]=3)) 
  (if (data_100[i,10]== "Actualite") (grappe[i]=3)) 
  (if (data_100[i,10]=="Voyages / mode") (grappe[i]=4)) 
} 
data=cbind(data_100,grappe)
View(data)
#par grappe :  
p=10   
gr=NULL 
sg=NULL 
y_bar_grappe=NULL 
var_ygrap=NULL 
y_grappe=NULL 
ng=NULL 
Th=NULL 
y_bar_h=NULL 
M=4 

m=2 
p1h=m/M #proba d'inclusion pi1h 
############## la définition des grappes  
for(j in 1:4){ 
  
  gr[j]=list(y[grappe==j])  
  
}


grappe  
########## l'echantillonage  
N=100 
Nh=as.vector(table(grappe))  
sg1=matrix(0,10,2) #la matrice qui va contenir les numero des grappes selctionnées 
for(i in 1:p){  
  sg=sample(1:4,m,replace=F)  
  sg1[i,2]=sg[2] 
  sg1[i,1]=sg[1] 
  sg1  
  Nhh=Nh[sg] #le nbre des individus dans chaque grappe selectionnée 
  ygrap=grappe[sg] 
  y_grappe[i]=list(unlist(ygrap))  
  ng[i]=list(length(unlist(ygrap)))  
  y_bar_h[1]=mean(unlist(ygrap[1])) 
  y_bar_h[2]=mean(unlist(ygrap[2])) 
  y_bar_grappe[i]=list((M/(m*N))*sum(Nhh*y_bar_h)) #les y bar estimés 
  Th[1]=sum(unlist(ygrap[1])) 
  Th[2]=sum(unlist(ygrap[2])) 
  var_ygrap[i]=list(  ((((M-m)*M)/((M-1)*m))*sum(((Th)-((1/M)*sum(y)))^2))/N^2  ) 
  
} 
d=cbind(mean(unlist(grappe[1])),mean(unlist(grappe[2])),mean(unlist(grappe[3])),mean(unlist(grappe[4]))) 
d=rbind(d,Nh) 
View(d) 
colnames(d)=c("grappe1","grappe2","grappe3","grappe4") 
rownames(d)=c("moyenne","taille de grappe") 

d=d[-2,] 
mean(unlist(grappe[4])) 
res=cbind(y_bar_grappe,var_ygrap,sg1)  
colnames(res)=c("y_bar_grappe","var_ygrap","grappe1","grappe2") 
y_bar_grappe=as.numeric(y_bar_grappe) # les y bar estimés 
var_ygrap=as.numeric(var_ygrap)  
icinf_grappe=NULL 
icsup_grappe=NULL 
intervalle_grappe=NULL 
longIC_grap=NULL 
for(i in 1:p){  
  icinf_grappe[i]=(y_bar_grappe[i])-1.96*sqrt(var_ygrap[i]) 
  icsup_grappe[i]=(y_bar_grappe[i])+1.96*sqrt(var_ygrap[i]) 
  intervalle_grappe[i]=list(c(icinf_grappe[i],icsup_grappe[i])) 
  longIC_grap[i]=list(icsup_grappe[i]-icinf_grappe[i]) 
} 
mean(unlist(longIC_grap))  
mugrap=mean(y_bar_grappe) #la moyenne des y_bar_grappe 
mugrap #la moyenne des y_bar_grappe 
longIC_grap=unlist(longIC_grap) 
res_grappe=NULL #le tableau recaputilatif  
res_grappe=data.frame(y=1:10,y_bar_grappe,var_ygrap,icinf_grappe,icsup_grappe,longIC_grap) 
g1_grappe=ggplot(res_grappe,aes(y,icsup_grappe))+geom_point(colour="#660066",cex=4)+geom_point(aes(y,icinf_grappe ),colour="firebrick1",cex=4)+geom_path(colour="#660066",size=1)+geom_path(aes(y,icinf_grappe),colour="firebrick1",size =1) 

g2_grappe=annotate("text", label =c("La borne inférieure","La borne supérieure"), x =c(3,3), y =c(1,1.5),size =5, colour = c("firebrick1","#660066")) 
g3_grappe=labs(x="",y="") 
g1_grappe+g2_grappe+g3_grappe+ggtitle("les 10 intervalles de confiance \n par grappes")+theme(plot.title = element_text(color="black", size=14, face="bold.italic")) 
res_grappe=res_grappe[,-1] 
res_grappe=cbind(res_grappe,sg1) 
colnames(res_grappe)=c("y_bar_grappe","var_ygrap","icinf_grappe","icsup_grappe","longIC_grap","num_1ere_grap_selct" ,"num_2ere_grap_selct") 
View(res_grappe) 

###########################
## 2 degrés################
###########################  
nh1=round(Nh/5) #le nombre des individus qui peuvent etre selectionnés dans chaque grappe 
grappe_2dg=NULL 
############ les m unités primaires 
for(i in 1:4){ 
  grappe_2dg[i]=list(y[grappe==i])  
} 
grappe_2dg  
sg2dg=matrix(0,10,2) ###### la matrice des numeros des grappes selectionnées 
nb=matrix(0,10,2) ##########  la matrice des nombres des indivdus selectionnés dans chaque grappe 
y_grappe_D2=NULL 
y_bar_grappe2=NULL 
y_bar_h2dg=NULL 
th2=NULL 
var_ygrap2=NULL 
ng1=NULL 
m=2 
t=sum(y) 
sg_2dg=NULL 

var_y_bar_grap_2dg=NULL 
for(i in 1:p){  
  sg2=sample(1:4,m,replace=F)  
  sg2dg[i,2]=sg2[2] 
  sg2dg[i,1]=sg2[1] 
  sg2dg  
  Nh_2dg=Nh[sg2] 
  ygrap2=grappe_2dg[sg2] 
  y_grappe_D2[i]=list(unlist(ygrap2)) 
  ng1[i]=list(length(unlist(ygrap2))) 
  sg_2dg[1]=list(sample(unlist(ygrap2[1]),nh1[sg2][1],replace=F)) 
  sg_2dg[2]=list(sample(unlist(ygrap2[2]),nh1[sg2][2],replace=F)) 
  nb[i,1]=nh1[sg2][1] 
  nb[i,2]=nh1[sg2][2] 
  y_bar_h2dg[1]=mean(unlist(sg_2dg[1])) 
  y_bar_h2dg[2]=mean(unlist(sg_2dg[2])) 
  q=sum(unlist(sg_2dg[1])) 
  a=sum(unlist(sg_2dg[2])) 
  q=c(q,a) 
  y_bar_grappe2[i]=list((sum((M/m)*(Nh_2dg/nh1[sg2])*q))/N) ###### les y bar estimés 
  th2[1]=sum(unlist(sg_2dg[1]))  
  th2[2]=sum(unlist(sg_2dg[2])) 
  sigmah1=(Nh_2dg[1]/(Nh_2dg[1]-1))*var(unlist(ygrap2[1])) 
  sigmah2=(Nh_2dg[2]/(Nh_2dg[2]-1))*var(unlist(ygrap2[2])) 
  sigma=c(sigmah1,sigmah2) 
  x=((M^2)*(M-m))/(M*m*(M-1)) 
  u=(sum(th2-(t/M)))^2 
  v=(M/m)*((Nh_2dg^2)/nh1[sg2])*(Nh_2dg-nh1[sg2]) 
  var_y_bar_grap_2dg[i]=((x*u)+sum(v*sigma))/(N^2) # la variance de l'estimateur 
}  

res1=cbind(y_bar_grappe2,var_y_bar_grap_2dg,sg2dg,nb) 
colnames(res1)=c("y_bar_grap_estimé","var_y_bar_grap_2dg","grappe1","grappe2","nh1","nh2")  
y_bar_grappe2=as.numeric(y_bar_grappe2) 
var_y_bar_grap_2dg=as.numeric(var_y_bar_grap_2dg)  
icinf_2dg=NULL 
icsup_2dg=NULL 
intervalle_2dg=NULL 
longIC_2dg=NULL 
for(i in 1:p){  
  icinf_2dg[i]=(y_bar_grappe2[i])-1.96*sqrt(var_y_bar_grap_2dg[i]) 
  icsup_2dg[i]=(y_bar_grappe2[i])+1.96*sqrt(var_y_bar_grap_2dg[i]) 
  intervalle_2dg[i]=list(c(icinf_2dg[i],icsup_2dg[i])) 
  longIC_2dg[i]=list(icsup_2dg[i]-icinf_2dg[i]) 
} 
mean(unlist(longIC_2dg))  
mu_2dg=mean(y_bar_grappe2) 
mu_2dg 
longIC_2dg=unlist(longIC_2dg) 
res_2dg=NULL #le tableau recaputilatif  
res_2dg=data.frame(y=1:10,y_bar_grappe2,var_y_bar_grap_2dg,icinf_2dg,icsup_2dg,longIC_2dg) 
g1_2dg=ggplot(res_2dg,aes(y,icsup_2dg))+geom_point(colour="darkgreen",cex=4)+geom_point(aes(y,icinf_2dg),colour="d eeppink",cex=4)+geom_path(colour="darkgreen",size=1)+geom_path(aes(y,icinf_2dg),colour="deeppink",size=1) 
g2_2dg=annotate("text", label =c("La borne inférieure","La borne supérieure"), x =c(3,3), y =c(3,3.5),size =5, colour = c("deeppink","darkgreen")) 
g3_2dg=labs(x="",y="") 
g1_2dg+g2_2dg+g3_2dg+ggtitle("les 10 intervalles de confiance \n à 2 degré")+theme(plot.title = element_text(color="black", size=14, face="bold.italic")) 
res_2dg=res_2dg[,-1] 
res_2dg=cbind(res_2dg,sg2dg,nb) 


colnames(res_2dg)=c("y_bar_grappe2","var_y_bar_grap_2dg","icinf_2dg","icsup_2dg","longIC_2dg","num_1ere_grap_selc t","num_2ere_grap_selct","nbre_ind_select_G1","nbre_ind_select_G2")  
View(res_2dg)
#######################
##synthese#############
#######################

##longeur IC
long_PEAR=res_pear[,6] 
long_PESR=res_pesr[,6] 
long_PIAR=ress[,6] 
long_strat_taille=res_strat[,6] 
long_strat_prop=res_prop[,6] 
long_strat_opt=res_opt[,6] 
long_grappe=res_grappe[,5] 
long_2deg=res_2dg[,5] 
long_PISR=tt[,5]   

tab=data.frame(y=1:20,long_grappe,long_2deg) 

###############synthese PEAR PESR PIAR PISR 
a=ggplot(tab,aes(y,long_PEAR))+geom_point(colour="darkgreen",cex=4)+ 
  geom_path(colour="darkgreen",size=1)+ 
  geom_point(aes(y,long_PESR),colour="deeppink",cex=4)+ 
  geom_path(aes(y,long_PESR),colour="deeppink",size=1)+ 
  geom_point(aes(y,long_PIAR),colour="blue",cex=4)+ 
  geom_path(aes(y,long_PIAR),colour="blue",size=1)+ 
  geom_point(aes(y,long_PISR),colour="black",cex=4)+ 
  geom_path(aes(y,long_PISR),colour="black",size=1) 
b=annotate("text", label =c("PESR","PEAR","PIAR","PISR"), x =c(18,18,18,18), y =c(4,4.25,4.5,4.75),size =8, colour = c("deeppink","darkgreen","blue","black")) 
c=labs(x="",y="") 
a+b+c+ggtitle("Synthèse des logueurs des intervalles de confaince \n PEAR PESR PIAR PISR")+theme(plot.title = element_text(color="black", size=14, face="bold.italic"))  
############# synthese stratification 
a=ggplot(tab,aes(y,long_strat_taille))+geom_point(colour="coral1",cex=4)+ 
  geom_path(aes(y,long_strat_taille),colour="coral1",size=1)+ 
  geom_point(aes(y,long_strat_prop),colour="green",cex=4)+ 
  geom_path(aes(y,long_strat_prop),colour="green",size=1)+ 
  geom_point(aes(y,long_strat_opt),colour="chocolate4",cex=4)+ 
  geom_path(aes(y,long_strat_opt),colour="chocolate4",size=1) 
b=annotate("text", label =c("strat_optimal","strat_prop","strat_mem_taille"), x =c(3,3,3), y =c(1.5,1.6,1.7),size =6, colour = c("chocolate4","green","coral1")) 
c=labs(x="",y="") 
a+b+c+ggtitle("Synthèse des logueurs des intervalles de confaince \n strat_egal prop opt")+theme(plot.title = element_text(color="black", size=14, face="bold.italic"))   
################# synthese grappe et 2degré 
library(ggplot2)
a=ggplot(tab,aes(y,long_grappe))+geom_point(colour="deeppink4",cex=4)+ 
  geom_path(aes(y,long_grappe),colour="deeppink4",size=1)+ 
  geom_point(aes(y,long_2deg),colour="indianred3",cex=4)+ 
  geom_path(aes(y,long_2deg),colour="indianred3",size=1) 
b=annotate("text", label =c("Grappe","2_degré"), x =c(19,19), y =c(7.5,8),size =7, colour = c("deeppink4","indianred3")) 
c=labs(x="",y="") 
a+b+c+ggtitle("Synthèse des logueurs des intervalles de confaince \n grappe et 2 degré")+theme(plot.title = element_text(color="black", size=14, face="bold.italic")) 

###### Comparaison de tous les types de sondages utilisés 

a=ggplot(tab,aes(y,long_PEAR))+geom_point(colour="darkgreen",cex=4)+ 
  geom_path(colour="darkgreen",size=1)+ 
  geom_point(aes(y,long_PESR),colour="deeppink",cex=4)+ 
  geom_path(aes(y,long_PESR),colour="deeppink",size=1)+ 
  geom_point(aes(y,long_PIAR),colour="blue",cex=4)+ 
  geom_path(aes(y,long_PIAR),colour="blue",size=1)+ 
  geom_point(aes(y,long_PISR),colour="black",cex=4)+ 
  geom_path(aes(y,long_PISR),colour="black",size=1)+ 
  geom_point(aes(y,long_strat_taille),colour="coral1",cex=4)+ 
  geom_path(aes(y,long_strat_taille),colour="coral1",size=1)+ 
  geom_point(aes(y,long_strat_prop),colour="green",cex=4)+ 
  geom_path(aes(y,long_strat_prop),colour="green",size=1)+ 
  geom_point(aes(y,long_strat_opt),colour="chocolate4",cex=4)+ 
  geom_path(aes(y,long_strat_opt),colour="chocolate4",size=1)+ 
  geom_point(aes(y,long_grappe),colour="deeppink4",cex=4)+ 
  geom_path(aes(y,long_grappe),colour="deeppink4",size=1)+ 
  geom_point(aes(y,long_2deg),colour="indianred3",cex=4)+ 
  geom_path(aes(y,long_2deg),colour="indianred3",size=1) 
b=annotate("text", label =c("strat_optimal","strat_prop","strat_mem_taille","PESR","PEAR","Grappe","PIAR","PISR","2_degré"), x =c(19,19,19,19,19,19,19,19,19), y =c(5.5,6,6.5,7,7.5,8,8.5,9,9.5),size =5, colour = c("chocolate4","green","coral1","deeppink","darkgreen","deeppink4","blue","black","indianred3")) 
c=labs(x="",y="") 
a+b+c+ggtitle("Synthèse des logueurs des intervalles de confaince")+theme(plot.title = element_text(color="black", size=14, face="bold.italic"))  
################
# Redressement #
################

library(MASS) 
library(lpSolve) 
library(sampling) 
n=20 
N=100 
# on tire par un sondage aleatoire simple un echantillon de taille n=20 
set.seed(1)
s=srswor(n,N) 
echantillon=y[s==1] 
moyenne=mean(echantillon) 
moyenne # moyenne de lechantillon = 3.5
##Alors l'estimateur de la moyenne avant redressement  est: 
moyenne  
##Or on connait que la proportion des femmes dans la population est 
P=sum(sexe=="Femme")/N 

P # la proprtion des hommes dans la pop = 0.34

p_ech=sum(sexe[s==1]=="Homme")/n 
p_ech #la proportion des hommes dans l'échantillon=0.6 
##L'estimateur de la moyenne après redressement est: 
moyenne.red=(P/p_ech)*moyenne 
moyenne.red  # est egale a 3.85 
# tous les individus donc ont le meme poids (P/p_ech) alors que sans redressement leur podis est(N/n)


