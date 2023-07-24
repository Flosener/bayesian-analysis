data {
  int<lower=0> N;
  vector[N] y;
  vector<lower=0>[N] sigma;
}
parameters {
  real mu;
  real<lower=0> sigma_prime;
  vector[N] nu; // theta_raw
}
transformed parameters {
  vector[N] theta;
  theta = mu + sigma_prime*nu;
}
model {
  mu ~ normal(0, 10);
  sigma_prime ~ cauchy(0, 10);
  nu ~ normal(0, 1);
  y ~ normal(theta, sigma);
}

// help: https://mc-stan.org/docs/2_22/stan-users-guide/reparameterization-section.html