#SCREENING FUNCTION

rm(list=ls(all=TRUE))

library("sensitivity")
library("randtoolbox")

ScreeningGenerator <- function(parametros, parametros_names, N, porcentaje_cambio, levels, grid_jump){
  
  beta <- function(algo0){
    
    
    
    beta <- 1/((0.19*log(16*algo0))^2)
    
    list(beta = beta)
    
  }
  
  
  
  minmax <- function(x,porcentaje){
    
    
    
    a<-x*porcentaje
    
    minimo <- x - a
    
    maximo <- x + a
    
    return(list(minimo,maximo))
    
  }
  
  set.seed(20)
  
  N_parameteres <- c(length(parametros))
  
  df <- data.frame(parametros_names,parametros,minmax(parametros,porcentaje = porcentaje_cambio)[1],minmax(parametros,porcentaje = porcentaje_cambio)[2]);names(df) <- c("parameters","initial","min","max")
  
  sub <- c(as.character.factor(df$parameters[grep("th",df$parameters)]))
  
  for (i in 1:length(sub)){
    
    f <- subset.data.frame(df, df$parameters == c(as.character.factor(df$parameters[grep("th",df$parameters)]))[i])
    
    if (f$min < 0){print("error min menor que 0")}
    
    if (f$max > 1){print("error max mayor que 1")}
    
  }
  
  sub <- c(as.character.factor(df$parameters[grep("n",df$parameters)]))
  
  for (i in 1:length(sub)){
    
    f <- subset.data.frame(df, df$parameters == c(as.character.factor(df$parameters[grep("n",df$parameters)]))[i])
    
    if (f$min < 1.001){print("error n menor que 1.001")}
    
  }
  
  sub <- c(as.character.factor(df$parameters[grep("n",df$parameters)]))
  
  for (i in 1:length(sub)){
    
    f <- subset.data.frame(df, df$parameters == c(as.character.factor(df$parameters[grep("n",df$parameters)]))[i])
    
    if (f$min < 1.001){print("error n menor que 1.001")}
    
  }
  
  #######################################SCREENING parameter set###############
  
  a <- morris(model = NULL,factors = parametros_names,r = N,design = (list(type = "oat",levels = levels, grid.jump = grid_jump)),binf = df$min,bsup = df$max,scale = T)
  
  return(a)
  
}



###screeninggeneration



ks<-(4.715819E-03);thsfr<-(0.8) ;alphafr<-(0.145) ;

nfr<-(2.68) ;ksfr<-(45.6871) ;lfr<-(0.5) ;wrel<-(0.00036);gamma<-(0.4) ;a<-(7.35) ;kas<-(4.440434E-03)

# beta1 <- (0.62)

parametros <- c(ks,thsfr,alphafr,nfr,ksfr,lfr,wrel,gamma,a,kas)

parametros_names <- c("ks","thsfr" ,"alphafr" ,"nfr" ,"ksfr" ,"lfr" ,"wrel","gamma" ,"a" ,"kas")

a <- ScreeningGenerator(parametros = parametros,parametros_names = parametros_names, N = 300, porcentaje_cambio = 0.20, levels = 6, grid_jump = 3)

#aa <- morris(model = NULL,factors = parametros_names,r = 300,design = (list(type = "oat",levels = 6, grid.jump = 3)),scale = T)

# pairs(aa$X)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               