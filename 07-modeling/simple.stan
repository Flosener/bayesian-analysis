data {
  int N;
  real Y[N]; // heights for N people
}
/*
transformed data {
  vector[N] lSqDeviation;
  for(i in 1:N) {
    lSqDeviation[i] = (Y[i] - mean(Y))^2; 
  }
}
*/
parameters {
  real mu;
  real<lower=0> sigmaSq; // sd of height distribution
}
transformed parameters {
  real sigma;
  sigma = sqrt(sigmaSq)
}
model {
  for(i in 1:10) {
    Y[i] ~ normal(mu, sigma); // likelihood
  }
  mu ~ normal(1.5,0.1); // prior for mu
  sigmaSq ~ gamma(5,1); // prior for variance
}
generated quantities {
  int aMax_indicator;
  int aMin_indicator;
  // local block to avoid memory issues
{ vector[10] lSimData;
  // Generate posterior predictive samples
  for(i in 1:10) {
    lSimData[i] = normal_rng(mu,sigma);
  }
  
  // Compare with real data
  aMax_indicator = max(lSimData) > max(Y);
  aMin_indicator = min(lSimData) < min(Y);
}
}