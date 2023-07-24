data {
  int<lower=1> N ;
  vector[N] y ;
}
parameters {
  real mu ;
  real sigma ;
} 
model {
  y ~ normal(mu, sigma) ;
}
