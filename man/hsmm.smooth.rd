\name{hsmm.smooth}
\alias{hsmm.smooth}
\title{Hidden Semi-Markov Models}
\description{Decoding states in Hidden Semi-Markov Models}
\usage{hsmm.smooth(x, 
                    od, 
                    rd, 
                    pi.par,
                    tpm.par,
                    od.par,
                    rd.par,
                    M = NA)}
\arguments{
  \item{        x}{the observed process, a vector of length \eqn{\tau}}
  \item{       od}{character containing the name of the conditional distribution of the observations. For details see \code{hsmm}}
  \item{       rd}{character containing the name of the runlength distribution (or sojourn time, dwell time distribution). For details see \code{hsmm}}
  \item{   pi.par}{vector of length \eqn{J} containing the values for the intitial probabilities of the semi-Markov chain}
  \item{  tpm.par}{matrix of dimension \eqn{J x J} containing the parameter values for the transition probability matrix of the embedded Markov chain. 
                   The diagonal entries must all be zero, absorbing states are not permitted}
  \item{   rd.par}{list with the values for the parameters of the runlength distributions. For details see \code{hsmm}}
  \item{   od.par}{list with the values for the parameters of the conditional observation distributions. For details see \code{hsmm}}
  \item{        M}{positive integer containing the maximum runlength}
  }
\details{The function \code{hsmm.smooth} calculates the so-called smoothed probabilities 
\deqn{P(S_t = i | X_0, ... , X_{\tau-1)}}{%
P(S[t] = i | X[1], ... , X[tau])}
for all \eqn{t \in 0, ... , \tau-1} and \eqn{i \in 0,...,J-1}. This procedure is often termed 'local decoding'. 
The sequence of the most probable states follows directly. 
Note that this sequence is not necessarily the most probable state sequence, which is determined by the Viterbi algorithm.}
\value{
  \item{call}       {call}
  \item{smooth.prob}{matrix of dimension \eqn{J \times \tau}{J x tau} containing the smoothed probabilities}
  \item{path}       {vector of length \eqn{\tau}{tau} containing sequence of the states with the highest probabilities}      
      }
\seealso{\code{\link{hsmm}}, \code{\link{hsmm.sim}}, \code{\link{hsmm.viterbi}}}

\keyword{ts}
