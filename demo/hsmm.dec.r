fit.vi <- hsmm.viterbi(sim$obs, od = "norm", rd = "log", 
                       pi.par = pipar, tpm.par = tpmpar, 
                       od.par = odpar, rd.par = rdpar)
fit.sm <- hsmm.smooth(sim$obs, od = "norm", rd = "log", 
                      pi.par = pipar, tpm.par = tpmpar, 
                      od.par = odpar, rd.par = rdpar)
fit.vi$path[1:15]
fit.sm$path[1:15]
round(fit.sm$sm[, 1:15], 2)
