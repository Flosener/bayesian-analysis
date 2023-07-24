data { 
  int<lower=1> p;  
  int<lower=0> k[p];   
  int<lower=1> n;
}
parameters {
  real<lower=.5,upper=1> phi; 
} 
transformed parameters {
  vector[2] alpha[p];
  for (i in 1:p) {
    alpha[i,1] = log(.5) + binomial_lpmf(k[i] | n, phi);
    alpha[i,2] = log(.5) + binomial_lpmf(k[i] | n, 0.5); 
  }
}
model {
  for (i in 1:p)
    target += log_sum_exp(alpha[i]);
}
generated quantities {
  int<lower=0,upper=1> z[p];
  for (i in 1:p) {
    z[i] = bernoulli_rng(softmax(alpha[i])[1]);
  }
}
