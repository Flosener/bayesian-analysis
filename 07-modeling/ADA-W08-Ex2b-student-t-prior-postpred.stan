data {
  int<lower=1> N ;
  vector[N] y ;
}
parameters {
  real mu ;
  real<lower=0> sigma ;
} 
model {
  // priors for parameters
  mu ~ normal(0,100);
  sigma ~ cauchy(0,10);
  y ~ student_t(1,mu,sigma);
}
generated quantities {
  // samples from the posterior predictive distribution
  // notice that, given the code above, mu and sigma are constraint to
  // be samples from the posterior at run time
  real yrep;
  yrep = student_t_rng(1,mu,sigma);
}