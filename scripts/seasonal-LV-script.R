# introduction to lotka-volterra modeling
source("install-packages.R")

#### do the things  ####
# first just start "basic" L-V models
# from https://assemblingnetwork.wordpress.com/2013/01/31/two-species-predator-prey-systems-with-r/
parameters <- c(r = 1.15, alpha = 0.01, q = 0.4)
state <- c(N = 50, P = 20)

lvmodel  <- function(t, state, parameters){
  with(as.list(c(state, parameters)),{
    #rate of change
    dN <- (r*N)-(alpha*N*P)
    dP <- (alpha*N*P)-(q*P)
    
    list(c(dN,dP))
  })
}

times <- seq(0,1000, by = 0.1)
out <- ode(y = state, times = times, func = lvmodel, parms = parameters)
plot(out[,2], out[,3], typ = "l", ylab = "Predator Abundance", xlab = "Prey Abundance")
abline(v = 0.4/0.01)
abline(h = 1.15/0.01)

matplot(x = out[,1], y = out[,c(2,3)], type = "l")

## density dependence ##
parameters2 <- c(r = 2.0, alpha = 0.1, e = 0.1, q = 0.5, K = 600)

lvmodel2 <- function(t, state, parameters){
  with(as.list(c(state, parameters)),{
    dN <- (r*N*(1-N/K)) - (alpha*N*P)
    dP <- (e*alpha*N*P) - (q*P)
    
    list(c(dN, dP))
  })
}

out2 <- ode(y = state, times = times, func = lvmodel2, parms = parameters2)
plot(out2[,2], out2[,3], type = "l")
plot(out2)
### ratio dependence ###
parameters3 <- c(r = 2, alpha = 0.5, e = 0.1, q = 0.25, K = 600, h = 0.1)
state3 <- c(N= 500, P = 100)
lvmodel3 <- function(t, state, parameters){
  with(as.list(c(state, parameters)),{
    dN <- (r*N*(1-N/K)) - ((alpha*N)/(P+alpha*h*N))*P
    dP <- (e*((alpha*N)/(P+alpha*h*N))*P) - (q*P)
    
    list(c(dN, dP))
  })
}

out3 <- ode(y = state3, times = times, func = lvmodel3, parms = parameters3)
plot(x = out3[,2], out3[,2], type = "l")

plot(out3)
# simulate seasonal growth rate of prey (algae)
# create light scaled 0 - 1
light <- photoperiod(1:365, 65) %>% scales::rescale

