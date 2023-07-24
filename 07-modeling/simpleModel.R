# load necessary packages
library(rstan)
library(ggplot2)
library(shinystan)
# let RStan run on multiple processors
options(mc.cores = parallel::detectCores())

# Creating the data
N <- 10
Y <- rnorm(N, 1.5, 0.2)

# Compile and run MCMC algorithm on Stan
fit <- stan(
  "simple.stan", 
  iter=200, 
  chains=4, 
  data=list(Y=Y))

# Print summary of fitted model
print(fit, probs=c(0.25, 0.5, 0.75))

# extract mean posterior samples and plot
mu <- extract(fit, 'mu')[[1]]
qplot(mu)

# use shinystan (browser-based)
aFit <- as.shinystan(fit)
launch_shinystan(aFit)