functions {
  real covariateMean(real aX, real aBeta) {
    return(aBeta * log(aX));
  }
}
data {
  int N; // number of people in data
  real Y[N]; // heights for N people
  real X[N]; // weights for N people
}
parameters {
  real beta;
  real<lower=0> sigma; // sd of height distribution
}
model {
  for(i in 1:N) {
    Y[i] ~ normal(covariateMean(X[i], beta), sigma); // likelihood
  }
  beta ~ normal(0,1); // prior for beta
  sigma ~ gamma(1,1); // prior for sigma
}