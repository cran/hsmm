pipar  <- rep(1/3, 3)
tpmpar <- matrix(c(0, 0.5, 0.5, 
                   0.7, 0, 0.3, 
                   0.8, 0.2, 0), 3, byrow = T)
rdpar  <- list(p = c(0.98, 0.98, 0.99))
odpar  <- list(mean = c(-1.5, 0, 1.5), var=c(0.5, 0.6, 0.8))
fit    <- hsmm(sim$obs, od = "norm", rd = "log", 
               pi.par = pipar, tpm.par = tpmpar, 
               od.par = odpar, rd.par = rdpar)

# the log-likelihood

fit$logl

# the estimated parameters for the observation distribution

fit$para$od

