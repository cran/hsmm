\name{hsmm}
\alias{hsmm}
\title{Hidden Semi-Markov Models}
\description{Fitting Hidden Semi-Markov Models}
\usage{hsmm(x, od, rd, pi.par, tpm.par, od.par, rd.par,
                 M         = NA,
                 Q.max     = 500, 
                 epsilon   = 1e-08,  
                 censoring = 1,
                 prt       = TRUE,
                 detailed  = FALSE,
                 r.lim     = c(0.01, 100), 
                 p.log.lim = c(0.001, 0.999),
                 nu.lim    = c(0.01, 100))}
\arguments{
  \item{        x}{the observed process, a vector of length \eqn{\tau}}
  \item{       od}{character with the name of the conditional distribution of the observations: 
                   "bern" = Bernoulli, "norm" = Normal, "pois" = Poisson, "t" = Student-t}
  \item{       rd}{character with the name of the runlength distribution (or sojourn time, dwell time distribution): 
                   "nonp" = Non-parametric, "geom" = Geometric, "nbinom" = Negative Binomial, "log" = Logarithmic, , "pois" = Poisson}
  \item{   pi.par}{vector of length \eqn{J} with the initial values for the initial probabilities of the semi-Markov chain}
  \item{  tpm.par}{matrix of dimension \eqn{J x J} with the initial values for the transition probability matrix of the embedded Markov chain. 
                   The diagonal entries must all be zero; absorbing states are not permitted}
  \item{   rd.par}{list with the initial values for the parameters of the runlength distributions. 
                   See further details below (section 'List Objects rd.par and od.par')}
  \item{   od.par}{list with the initial values for the parameters of the conditional observation distributions. 
                   See further details below (section 'List Objects rd.par and od.par')}
  \item{        M}{positive integer containing the maximum runlength}
  \item{    Q.max}{positive integer containing the maximum number of iterations}
  \item{  epsilon}{positive scalar giving the tolerance at which the relative change of 
                   log-likelihood is considered close enough to zero to terminate the algorithm.}
  \item{censoring}{integer. if equal to \eqn{1}, the last visited state contributes to the likelihood. 
                   If equal to \eqn{0}, the partial likelihood estimator, which ignores the contribution of the last visited state, is used. 
                   For details see Guedon (2003)}
  \item{      prt}{logical. if TRUE, the log-likelihood and number of iterations carried out are printed for each iteration}
  \item{ detailed}{logical. if TRUE, a list of the parameters at every iteration step is written into the \code{ctrl} list}
  \item{    r.lim}{upper and lower bound for the r parameter of the negative binomial distribution in the M-step, 
                   bisection is applied to determine this parameter}
  \item{p.log.lim}{upper and lower bound for the parameter of the logarithmic distribution in the M-step, 
                   bisection is applied to determine this parameter}
  \item{   nu.lim}{upper and lower bound for the degrees of freedom of parameter of the t distribution in the M-step, 
                   bisection is applied to determine this parameter}
          }
\details{The function \code{hsmm} fits a Hidden Semi-Markov Model using the EM-Algorithm for parameter estimation. The estimation algorithms are based on the right-censored approach initially described in Guedon (2003).}
\value{
  \item{call}{call}
  \item{iter}{positive integer containing the number of iterations carried out}
  \item{logl}{double containing log-likelihood of the fitted model}
  \item{para}{list object containing the parameter estimates}
  \item{ctrl}{list object containing additional control variables. These are \code{solution.reached}, \code{error}, and \code{details}.
              \code{solution.reached} is TRUE, if the stopping criterion is fulfilled. 
              \code{error} returns an error code: 0 = no error, 1 = internal probability less or equal to zero, 2 = memory exception, 
                           3 = file error (internal output from C routine, disabled by default).
              \code{details} contains the parameter values of every iteration.}
      }
\section{List Objects rd.par and od.par}{
                               The list objects \code{rd.par} and \code{od.par} contain parameter values for the runlength and conditional
                               observation distribution, respectively. For a model with \eqn{J} states, the length of all parameter vectors
                               is equal to \eqn{J}. For non-parametric runlength distribution, the corresponding entry is 
                               a matrix of dimension \eqn{M x J}.
                               The names of the list entries have to be as follows. \cr
                               \code{od.par} \cr
                               "bern" (Bernoulli): "b" \cr 
                               "norm" (Normal):    "mean", "var" \cr
                               "pois" (Poisson):   "lambda" \cr
                               "t"    (Student-t): "mean", "var", "df" \cr
                               \code{rd.par} \cr
                               "nonp"   (Non-parametric):    "np" \cr
                               "geom"   (Geometric):         "p" \cr
                               "nbinom" (Negative Binomial): "r", "pi" \cr
                               "log"    (Logarithmic):       "p" \cr
                               "pois"   (Poisson):           "lambda" 
                               }
\references{
  Bulla, J. (2006), Stylized facts of financial time series and hidden semi-Markov models. Ph.D. thesis, Goettingen. \cr
  Guedon, Y. (2003), Estimating Hidden Semi-Markov Chains From Discrete Sequences. JCGS, 12 (3), pp 604-639. 
  }
\seealso{\code{\link{hsmm.smooth}}, \code{\link{hsmm.viterbi}}, \code{\link{hsmm.sim}}}

\keyword{ts}
