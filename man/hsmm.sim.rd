\name{hsmm}
\alias{hsmm.sim}
\title{Hidden Semi-Markov Models}
\description{Simulating Hidden Semi-Markov Models}
\usage{hsmm.sim(tau,
                od, 
                rd, 
                pi.par,
                tpm.par,
                od.par,
                rd.par,
                M = NA,
                seed = NULL)}
\arguments{
  \item{      tau}{positive integer containing number of observations to simulate}
  \item{       od}{character containing the name of the conditional distribution of the observations. For details see \code{hsmm}}
  \item{       rd}{character containing the name of the runlength distribution (or sojourn time, dwell time distribution). For details see \code{hsmm}}
  \item{   pi.par}{vector of length \eqn{J} containing the values for the intitial probabilities of the semi-Markov chain}
  \item{  tpm.par}{matrix of dimension \eqn{J x J} containing the parameter values for the transition probability matrix of the embedded Markov chain. 
                   The diagonal entries must all be zero, absorbing states are not permitted}
  \item{   rd.par}{list with the values for the parameters of the runlength distributions. For details see \code{hsmm}}
  \item{   od.par}{list with the values for the parameters of the conditional observation distributions. For details see \code{hsmm}}
  \item{        M}{positive integer containing the maximum runlength}
  \item{     seed}{integer. Seed for the random number generator}
          }
\details{The function \code{hsmm.sim} simulates the observations and the underlying state sequence of a 
  Hidden Semi-Markov Model. 
  Simulation requires the determination of the runlength and the conditional observation distributions 
  as well as all parameters. \cr
  Note: The simulation of t-distributed conditional observations carries out the function \code{rmt}, 
  which is extracted from the package \code{csampling} (by Alessandra R. Brazzale).}
\value{
  \item{call}{call}
  \item{obs} {vector of length the \eqn{\tau} containing simulated observations}
  \item{path}{vector of length the \eqn{\tau} containing the simulated underlying semi-Markov chain}
      }
\seealso{\code{\link{hsmm}}, \code{\link{hsmm.smooth}}, \code{\link{hsmm.viterbi}}}

\keyword{ts}
