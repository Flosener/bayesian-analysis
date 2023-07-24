# load necessary packages
library(rstan)
library(ggplot2)
library(shinystan)
# let RStan run on multiple processors
options(mc.cores = parallel::detectCores())

# Creating the data
N <- 100
X <- rnorm(N,60,10)
beta <- 0.3
sigma <- 0.3
Y <- beta * log(X) + rnorm(N, 0, sigma)

# Compile and run MCMC algorithm on Stan
fit <- stan(
  "covariate.stan", 
  iter=200, 
  chains=4, 
  data=list(Y=Y, X=X, N=N))

# Print summary of fitted model
print(fit, probs=c(0.25, 0.5, 0.75))