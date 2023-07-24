data {
  int<lower=1> N1;
  int<lower=1> N2;
  vector[N1] y1;
  vector[N2] y2;
}
parameters {
  real mu1;
  real mu2;
  real<lower=0> sigma1;
  real<lower=0> sigma2;
} 
model {
  // priors for parameters
  mu1 ~ normal(0,100);
  mu2 ~ normal(0,100);
  sigma1 ~ cauchy(0,10);
  sigma2 ~ cauchy(0,10);
  y1 ~ normal(mu1, sigma1);
  y2 ~ normal(mu2, sigma2);
}
generated quantities {
  real delta;
  delta = mu2 - mu1;
}