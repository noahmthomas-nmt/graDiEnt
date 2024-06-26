% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/optim_SQGDE.R
\name{optim_SQGDE}
\alias{optim_SQGDE}
\title{optim_SQGDE}
\usage{
optim_SQGDE(ObjFun, control_params = GetAlgoParams(), ...)
}
\arguments{
\item{ObjFun}{A scalar-returning function to minimize whose first argument is a real-valued n_params-dimensional vector.}

\item{control_params}{control parameters for SQG-DE algo. see \code{\link{GetAlgoParams}} function documentation for more details. The only argument you NEED to pass here is n_params.}

\item{...}{additional arguments to pass ObjFun.}
}
\value{
list containing solution and it's corresponding weight (i.e. f(solution)).
}
\description{
Runs Stochastic Quasi-Gradient Differential Evolution (SQG-DE; Sala, Baldanzini, and Pierini, 2018) to minimize an objective function f(x). To maximize a function f(x), simply pass g(x)=-f(x) to ObjFun argument.
}
\examples{
##############
# Maximum Likelihood Example
##############

# simulate from model
dataExample=matrix(rnorm(1000,c(-1,1,0,1),c(1,1,1,1)),ncol=4,byrow = TRUE)

# list parameter names
param_names_example=c("mu_1","mu_2","mu_3","mu_4")

# negative log likelihood
ExampleObjFun=function(x,data,param_names){
  out=0

  names(x) <- param_names

  # log likelihoods
  out=out+sum(dnorm(data[,1],x["mu_1"],sd=1,log=TRUE))
  out=out+sum(dnorm(data[,2],x["mu_2"],sd=1,log=TRUE))
  out=out+sum(dnorm(data[,3],x["mu_3"],sd=1,log=TRUE))
  out=out+sum(dnorm(data[,4],x["mu_4"],sd=1,log=TRUE))

  return(out*-1)
}

########################
# run optimization
out <- optim_SQGDE(ObjFun = ExampleObjFun,
                   control_params = GetAlgoParams(n_params = length(param_names_example),
                                             n_iter = 250,
                                              n_particles = 12,
                                              n_diff = 2,
                                              return_trace = TRUE),
                   data = dataExample,
                   param_names = param_names_example)
old_par <- par() # save graphic state for user
# plot particle trajectory

par(mfrow=c(2,2))
matplot(out$particles_trace[,,1],type='l')
matplot(out$particles_trace[,,2],type='l')
matplot(out$particles_trace[,,3],type='l')
matplot(out$particles_trace[,,4],type='l')

#SQG DE solution
out$solution

#analytic solution
apply(dataExample, 2, mean)

par(old_par) # restore user graphic state

}
