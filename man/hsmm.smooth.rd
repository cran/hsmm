\name{hsmm.smooth}
\alias{hsmm.smooth}
\title{Hidden Semi-Markov Models}
\description{Inference on the hidden states for given observations and model specifications of a hidden semi-Markov model. 
             For every observation, the function calculates the probability of being in a particular state.}
\usage{hsmm.smooth(x, 
            od, 
            rd, 
            pi.par,
            tpm.par,
            od.par,
            rd.par,
            M = NA)}
\arguments{
  \item{        x}{The observations as a vector of length \eqn{T}{T}.}
  \item{       od}{Character containing the name of the conditional distribution of the observations. For details see \code{\link{hsmm}}.}
  \item{       rd}{Character containing the name of the runlength distribution (or sojourn time, dwell time distribution). For details see \code{\link{hsmm}}.}
  \item{   pi.par}{Vector of length \eqn{J}{J} containing the values for the intitial probabilities of the semi-Markov chain.}
  \item{  tpm.par}{Matrix of dimension \eqn{J \times J}{J x J} containing the parameter values for the transition probability matrix of the embedded Markov chain. 
                   The diagonal entries must all be zero, absorbing states are not permitted.}
  \item{   rd.par}{List with the values for the parameters of the runlength distributions. For details see \code{\link{hsmm}}.}
  \item{   od.par}{List with the values for the parameters of the conditional observation distributions. For details see \code{\link{hsmm}}.}
  \item{        M}{Positive integer containing the maximum runlength.}
  }
\details{The function \code{hsmm.smooth} calculates the so-called smoothed probabilities 
\deqn{P(S_t = i | X_1, ... , X_{T})}{%
P(S[t] = i | X[1], ... , X[T])}
for all \eqn{t \in 1, ... , T}{t in 1, ... , T} and \eqn{i \in 1,...,J}{i in 1,...,J}, with \eqn{X}{X} denoting the observations and 
\eqn{S}{S} the hidden states. This procedure is often termed 'local decoding'. 
The sequence of the most probable states follows directly. 
Note that this sequence is not necessarily the most probable state sequence, which is determined by the Viterbi algorithm. 
Also note that local decoding may ignore restrictions imposed by the transition probability matrix, such as forbidden transitions,
because it optimizes locally for every single observation.}
\value{
  \item{call}{The matched call.}
  \item{smooth.prob}{A matrix of dimension \eqn{J \times T}{J x T} containing the smoothing probabilities.}
  \item{path}{A vector of length \eqn{T}{T} containing the sequence of the states with the highest probabilities.}      
      }

\seealso{\code{\link{hsmm}}, \code{\link{hsmm.sim}}, \code{\link{hsmm.viterbi}}}

\keyword{ts}

\examples{
# Simulating observations: 
# (see hsmm.sim for details)
pipar  <- rep(1/3, 3)
tpmpar <- matrix(c(0, 0.5, 0.5,
                   0.7, 0, 0.3,
                   0.8, 0.2, 0), 3, byrow = TRUE)
rdpar  <- list(p = c(0.98, 0.98, 0.99))
odpar  <- list(mean = c(-1.5, 0, 1.5), var = c(0.5, 0.6, 0.8))
sim    <- hsmm.sim(n = 2000, od = "norm", rd = "log", 
                   pi.par = pipar, tpm.par = tpmpar, 
                   rd.par = rdpar, od.par = odpar, seed = 3539)

# Computation of the smoothing probabilities:
fit.sm <- hsmm.smooth(sim$obs, od = "norm", rd = "log", 
                      pi.par = pipar, tpm.par = tpmpar, 
                      od.par = odpar, rd.par = rdpar)

# The first 15 smoothing probabilities:
round(fit.sm$sm[, 1:15], 2)

# The first 15 values of the resulting path:
fit.sm$path[1:15]

# For comparison, the real/simulated path (first 15 values):
sim$path[1:15]
}

