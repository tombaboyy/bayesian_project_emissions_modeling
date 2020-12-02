
data {
  int <lower=0> N; // number of observation
  vector[N] y; // observations
}

parameters {
  real mu;
  real<lower=0> sigma;
}

model {
    mu ~ lognormal(2.58, 0.5); // prior
    sigma ~ gamma(2.5,0.8); // prior

  // pooled model likelihood, common mu and sigma for all observations
    y ~ normal(mu, sigma);
}


generated quantities {
  real ypred;
  vector[N] log_lik;
  
  //predictive distribution for any machine
  ypred = normal_rng(mu, sigma);
  for (i in 1:N){
      log_lik[i] = normal_lpdf(y[i] | mu, sigma);
  }
  
}

