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
  y ~ normal(mu, sigma) ;
}
generated quantities {
  // samples from the posterior predicitive distribution
  // notice that, given the code above, mu and sigma are constraint to
  // be samples from the posterior at runtime
  real yrep;
  yrep = normal_rng(mu, sigma); 
}
