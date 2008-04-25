\name{hsmm.viterbi}
\alias{hsmm.viterbi}
\title{Hidden Semi-Markov Models}
\description{Decoding states in Hidden Semi-Markov Models}
\usage{hsmm.viterbi(x, 
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
\details{The function \code{hsmm.viterbi} carries out the Viterbi algorithm. It derives the most probable state sequence by a dynamic programming technique. This procedure is often termed 'global decoding'.}
\value{
  \item{call}{call}
  \item{path}{vector of length the \eqn{tau} containing the most probable path of the underlying states}
      }
\seealso{\code{\link{hsmm}}, \code{\link{hsmm.sim}}, \code{\link{hsmm.smooth}}}

\keyword{ts}
