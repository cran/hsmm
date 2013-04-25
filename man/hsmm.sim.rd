\name{hsmm.sim}
\alias{hsmm.sim}
\title{Hidden Semi-Markov Models}
\description{Simulation of sequences of observations and underlying paths for hidden semi-Markov models.}
\usage{hsmm.sim(n,
         od, 
         rd, 
         pi.par,
         tpm.par,
         od.par,
         rd.par,
         M = NA,
         seed = NULL)}
\arguments{
  \item{        n}{Positive integer containing the number of observations to simulate.}
  \item{       od}{Character containing the name of the conditional distribution of the observations. For details see \code{\link{hsmm}}.}
  \item{       rd}{Character containing the name of the runlength distribution (or sojourn time, dwell time distribution). See \code{\link{hsmm}} for details.}
  \item{   pi.par}{Vector of length \eqn{J}{J} containing the values for the intitial probabilities of the semi-Markov chain.}
  \item{  tpm.par}{Matrix of dimension \eqn{J \times J}{J x J} containing the parameter values for the transition probability matrix of the embedded Markov chain. 
                   The diagonal entries must all be zero, absorbing states are not permitted.}
  \item{   rd.par}{List with the values for the parameters of the runlength distributions. For details see \code{\link{hsmm}}.}
  \item{   od.par}{List with the values for the parameters of the conditional observation distributions. For details see \code{\link{hsmm}}.}
  \item{        M}{Positive integer containing the maximum runlength.}
  \item{     seed}{Seed for the random number generator (integer).}
          }
\details{The function \code{hsmm.sim} simulates the observations and the underlying state sequence of a 
  hidden semi-Markov model. 
  The simulation requires the specification of the runlength and the conditional observation distributions 
  as well as all corresponding parameters. \cr
  Note: The simulation of t-distributed conditional observations is performed by the functions \code{rmt} and \code{rvm}, 
  extracted from the package \code{csampling} and \code{CircStats}, respectively.}
\value{
  \item{call}{The matched call.}
  \item{obs}{A vector of length \eqn{n}{n} containing the simulated observations.}
  \item{path}{A vector of length \eqn{n}{n} containing the simulated underlying semi-Markov chain.}
      }

\seealso{\code{\link{hsmm}}, \code{\link{hsmm.smooth}}, \code{\link{hsmm.viterbi}}}

\keyword{ts}

\examples{
# Simulation of sequences of observations and hidden states from a 
# 3-state HSMM with a logarithmic runlength distribution and a 
# conditional Gaussian distributions.

### Setting up the parameter values:
# Initial probabilities of the semi-Markov chain:
pipar  <- rep(1/3, 3)
# Transition probabilites:
# (Note: For two states, the matrix degenerates, taking 0 for the 
# diagonal and 1 for the off-diagonal elements.)
tpmpar <- matrix(c(0, 0.5, 0.5,
                   0.7, 0, 0.3,
                   0.8, 0.2, 0), 3, byrow = TRUE)
# Runlength distibution:
rdpar  <- list(p = c(0.98, 0.98, 0.99))
# Observation distribution:
odpar  <- list(mean = c(-1.5, 0, 1.5), var = c(0.5, 0.6, 0.8))

# Invoking the simulation:
sim    <- hsmm.sim(n = 2000, od = "norm", rd = "log", 
                   pi.par = pipar, tpm.par = tpmpar, 
                   rd.par = rdpar, od.par = odpar, seed = 3539)


# The first 15 simulated observations:
round(sim$obs[1:15], 3)

# The first 15 simulated states:
sim$path[1:15]
}
