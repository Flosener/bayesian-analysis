data {
  int<lower=1> N;
  int K;
  vector[N] group;
  vector[N] y;
}
parameters {
  real mu[K];
  real<lower=0> sigma[K];
} 
model {
  // likelihood
  for(i in 1:K) {
    for(j in 1:N) {
      if(i == group[j]) {
        y[j] ~ normal(mu[i], sigma[i]);
      }
    }
  }
  // priors
  mu ~ normal(0,100);
  sigma ~ cauchy(0,10);
}
generated quantities {
  real delta;
  delta = fabs(mu[2] - mu[1]);
}