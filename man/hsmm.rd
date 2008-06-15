\name{hsmm}
\alias{hsmm}
\title{Hidden Semi-Markov Models}
\description{Fitting a hidden semi-Markov model with conditional distribution \code{od} and runlength distribution \code{rd} to the observations \code{x}.}
\usage{hsmm(x, 
     od, 
     od.par,
     rd        = "nonp", 
     rd.par    = list(np = matrix(0.1, nrow = 10, ncol = 2)),
     pi.par    = c(0.5, 0.5),
     tpm.par   = matrix(c(0, 1, 1, 0), 2),
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
  \item{        x}{The observations as a vector of length \eqn{T}{T}.}
  \item{       od}{Character with the name of the conditional distribution of the observations. The following distributions are currently implemented: 
                   \tabular{lll}{
                   \code{"bern"} \tab = \tab Bernoulli \cr
                   \code{"norm"} \tab = \tab Normal \cr
                   \code{"pois"} \tab = \tab Poisson \cr
                   \code{"t"}    \tab = \tab Student-t
                   }}
  \item{       rd}{Character with the name of the runlength distribution (or sojourn time, dwell time distribution). The following distributions are currently implemented:
                   \tabular{lll}{
                   \code{"nonp"}   \tab = \tab Non-parametric \cr
                   \code{"geom"}   \tab = \tab Geometric \cr
                   \code{"nbinom"} \tab = \tab Negative Binomial \cr
                   \code{"log"}    \tab = \tab Logarithmic \cr 
                   \code{"pois"}   \tab = \tab Poisson
                   }}
  \item{   pi.par}{Vector of length \eqn{J}{J} with the initial values for the initial probabilities of the semi-Markov chain.}
  \item{  tpm.par}{Matrix of dimension \eqn{J \times J}{J x J} with the initial values for the transition probability matrix of the embedded Markov chain. 
                   The diagonal entries must all be zero; absorbing states are not permitted.}
  \item{   rd.par}{List with the initial values for the parameters of the runlength distributions. 
                   See further details below (section 'List Objects rd.par and od.par').}
  \item{   od.par}{List with the initial values for the parameters of the conditional observation distributions. 
                   See further details below (section 'List Objects rd.par and od.par').}
  \item{        M}{Positive integer containing the maximum runlength.}
  \item{    Q.max}{Positive integer containing the maximum number of iterations.}
  \item{  epsilon}{Positive scalar giving the tolerance at which the relative change of 
                   log-likelihood is considered close enough to zero to terminate the algorithm.}
  \item{ censoring}{Integer. If equal to \eqn{1}{1}, the last visited state contributes to the likelihood. 
                   If equal to \eqn{0}{0}, the partial likelihood estimator, which ignores the contribution of the last visited state, is used. 
                   For details see Guedon (2003).}
  \item{      prt}{Logical. if TRUE, the log-likelihood and number of iterations carried out are printed for each iteration.}
  \item{ detailed}{Logical. if TRUE, a list of the parameters at every iteration step is written into the \code{ctrl} list.}
  \item{    r.lim}{Upper and lower bound for the \eqn{r}{r} parameter of the negative binomial distribution in the M-step, 
                   bisection is applied to determine this parameter.}
  \item{ p.log.lim}{Upper and lower bound for the parameter of the logarithmic distribution in the M-step, 
                   bisection is applied to determine this parameter.}
  \item{   nu.lim}{Upper and lower bound for the degrees of freedom of parameter of the t distribution in the M-step, 
                   bisection is applied to determine this parameter.}
          }
\details{The function \code{hsmm} fits a hidden semi-Markov model using the EM algorithm for parameter estimation. 
         The estimation algorithms are based on the right-censored approach initially described in Guedon (2003).
         This model does not assume that the last observation coincides with an exit from the last visited state.
         The EM algorithm is an iterative procedure and requires initial values. 
         The results may depend on the initial values selected, because convergence to local maxima is a common phenomenon.
         Details on the algorithm utilized for the package \code{hsmm} are also presented by Bulla (2006). \cr
         
         Default model \cr
         The default model is a two-state HSMM with a non-parametric runlength distribution. 
         Thus, the TPM does not require any initial values
         (for models with \eqn{J > 2}{J > 2} states, the TPM may be initialized by the value \eqn{1/(J - 1)}{1/(J - 1)} for the off-diagonal elements). 
         The non-parametric runlength distribution is implemented as default distribution 
         and initialized by a uniform distribution on the first ten runlengths. 
         Similarly, the initial probabilities for \eqn{\pi}{pi} follow a uniform distribution. 
         There is no default for the conditional distribution of the observations, because it should not be selected without investigating the data.  
         We would like to point out that the non-parametric runlength distributuion often requires a 
         very high number of observations. Sansom and Thomson (2001), e.g., obtained satisfactory results with series of length 20000 and longer.}
\value{
  \item{call}{The matched call.}
  \item{iter}{Positive integer containing the number of iterations carried out.}
  \item{logl}{Double containing log-likelihood of the fitted model.}
  \item{para}{List object containing the parameter estimates.}
  \item{ctrl}{List object containing additional control variables. These are \code{solution.reached}, \code{error}, and \code{details}.
              \code{solution.reached} is TRUE, if the stopping criterion is fulfilled. 
              \code{error} returns an error code: 0 = no error, 1 = internal probability less or equal to zero, 2 = memory exception, 
                           3 = file error (internal output from C routine, disabled by default).
              \code{details} contains the parameter values of every iteration.}
      }
\section{List Objects rd.par and od.par}{
                               The list objects \code{rd.par} and \code{od.par} contain parameter values for the runlength and conditional
                               observation distribution, respectively. For a model with \eqn{J}{J} states, the length of all parameter vectors
                               is equal to \eqn{J}{J}. For non-parametric runlength distribution, the corresponding entry is 
                               a matrix of dimension \eqn{M \times J}{M x J}.
                               The names of the list entries have to be as follows. \cr
                               \code{od.par}: 
                               \tabular{lll}{
                               \code{"bern"} \tab (Bernoulli): \tab \code{"b"} \cr 
                               \code{"norm"} \tab (Normal):    \tab \code{"mean"}, \code{"var"} \cr
                               \code{"pois"} \tab (Poisson):   \tab \code{"lambda"} \cr
                               \code{"t"}    \tab (Student-t): \tab \code{"mean"}, \code{"var"}, \code{"df"}
                               }
                               \code{rd.par}: 
                               \tabular{lll}{
                               \code{"nonp"}   \tab (Non-parametric):    \tab \code{"np"} \cr
                               \code{"geom"}   \tab (Geometric):         \tab \code{"p"} \cr
                               \code{"nbinom"} \tab (Negative Binomial): \tab \code{"r"}, \code{"pi"} \cr
                               \code{"log"}    \tab (Logarithmic):       \tab \code{"p"} \cr
                               \code{"pois"}   \tab (Poisson):           \tab \code{"lambda"} 
                               }}
\references{
  Bulla, J. (2006), Stylized facts of financial time series and hidden semi-Markov models. Ph.D. thesis, Goettingen. \cr
  Guedon, Y. (2003), Estimating Hidden Semi-Markov Chains From Discrete Sequences. JCGS, 12 (3), pp 604-639. \cr
  Sansom, J. and Thomson, P. (2001), Fitting hidden semi-Markov models to breakpoint rainfall data. J. Appl. Probab., 38A, pp 142-157 
  }

\seealso{\code{\link{hsmm.smooth}}, \code{\link{hsmm.viterbi}}, \code{\link{hsmm.sim}}}

\keyword{ts}

\examples{

# Simulating observations: 
# (see hsmm.sim for details)
pipar  <- rep(1/3, 3)
tpmpar <- matrix(c(0, 0.5, 0.5,
                   0.7, 0, 0.3,
                   0.8, 0.2, 0), 3, byrow = TRUE)
rdpar  <- list(p = c(0.98, 0.98, 0.99))
odpar  <- list(mean = c(-1.5, 0, 1.5), var=c(0.5, 0.6, 0.8))
sim    <- hsmm.sim(n = 2000, od = "norm", rd = "log", 
                   pi.par = pipar, tpm.par = tpmpar, 
                   rd.par = rdpar, od.par = odpar, seed = 3539)

# Executing the EM algorithm:
fit    <- hsmm(sim$obs, od = "norm", rd = "log", 
               pi.par = pipar, tpm.par = tpmpar, 
               od.par = odpar, rd.par = rdpar)

# The log-likelihood:
fit$logl

# Ehe estimated parameters:
fit$para

# For comparison, the estimated parameters seperately together with the true parameter values
# ar given below.
# Transition probability matrix:
tpmpar
fit$para$tpm
# Observation distribution:
odpar
fit$para$od
# Runlength distribution:
rdpar
fit$para$rd
}

