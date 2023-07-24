// solution to exercise 1c
functions {
  // we need to define our own _rng function because
  // Stan (currently) doesn't allow truncated sampling functions
  real half_cauchy_rng(real spread) {
    return(fabs(cauchy_rng(0, spread)));
  }
}
data {
  int<lower=1> N ;
  vector[N] y ;
}
parameters {
  real mu ;
  real<lower =0> sigma ;
} 
model {
  // priors for parameters
  mu ~ normal(0,100);
  sigma ~ cauchy(0,10);
  y ~ normal(mu, sigma);
}
generated quantities {
  // samples from the prior predicitive distribution
  real mu_prior;
  real<lower =0> sigma_prior;
  real ypred; 
  mu_prior = normal_rng(0,100);
  sigma_prior = half_cauchy_rng(10);
  ypred = normal_rng(mu_prior, sigma_prior);
}
