hsmm.sim <- function(tau,
                     od, 
                     rd, 
                     pi.par,
                     tpm.par,
                     od.par,
                     rd.par,
                     M = NA,
                     seed = NULL){

  # set seed
  if (!is.null(seed)){ 
    set.seed(seed)
    }
    
  # package containing rtm for sampling from (multivar.) t distribution
  # require(csampling)

  # determine number of states
  J <- length(pi.par)
  
  # determination of the length of the runlength
  # 1000 suficcient for most applications
  # More than 1000 makes only sense if there are more than 1000 obs
  
  if (is.na(M)){
    if (rd == "non.parametric"){
      M <- as.integer(dim(rd.par$np)[1])
      } else {
      M <- as.integer(max(tau, 1000))
      }
    } # endif isna(M)
                    
  # write all parameters into one list
  Para     <- list()
  Para$pi  <- pi.par 
  Para$tpm <- t(tpm.par) 
  Para$rd  <- rd.par 
  Para$od  <- od.par
    
  # calculate the (approximation of the) runlength distribution
  RL <- matrix(get.d(rd, J = J, M = M, param = Para$rd), nrow=J, byrow=T)
    
  # sample the first visited state
  i <- sample(1:J, 1, prob = Para$pi) 

  # initialize the result variables and length of simulated series
  obs  <- c()
  path <- c()
  t    <- 0

  # generation of the TS
  while (t < tau)
  {
    # the number of observations to be generated
    no <- sample(c(1:length(RL[i, RL[i,]!=0])), p=RL[i, RL[i,]!=0], 1)

    # generation of the observations 
    # od = "Bernoulli"
    if (od == "bern"){
      obs <- c(obs, rbinom(no, 1, Para$od$b[i]))
    }
    # od = "Gaussian"
    if (od == "norm"){
      obs <- c(obs, rnorm(no, mean = Para$od$mean[i], sd = sqrt(Para$od$var[i])))
    }
    # od = "Poisson"
    if (od == "pois"){
      obs <- c(obs,rpois(no, Para$od$lambda[i]))
    }
    # od = "Student.t"
    if (od == "t"){
      obs <- c(obs, rmt(no, mm = Para$od$mean[i], cov = Para$od$var[i], df = Para$od$df[i]))    
    }

    # generation of the path
    path <- c(path, rep(i, no))

    # sample next state
    i <- sample(1:J, p=Para$tpm[, i], 1)

    # update the length of the obs
    t <- length(obs)
  }

  obs  <- obs[1:tau]
  path <- path[1:tau]
    
  out <- list(call   = match.call(),
              obs    = obs, 
              path   = path)
  return(out)

  }