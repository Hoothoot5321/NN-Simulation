float sigmoid(float x) {
  return 1/(1+exp(-x));
}

float derived_sigmoid(float x) {
  float fx = sigmoid(x);
  return fx*(1-fx);
}

float relu(float x) {
  float out = x*0.1;
  if (x>=out) {
    if (x>=6.0) {
      return 6.0;
    } else {
      return x;
    }
  } else {
    return out;
  }
}

float derived_relu(float x) {
  if (x > 0.0) {
    return 1.0;
  } else {
    return 0.1;
  }
}

float[] softmax(float[] input) {

  float soft_sum = 0;
  for(float val:input) {
    soft_sum+=exp(val);
  }
  float[] soft_arr = new float[input.length];
  for(int i = 0; i< input.length;i++) {
    soft_arr[i] = exp(input[i])/soft_sum;
  }
  return soft_arr;
}

float[] safe_softmax(float[] input) {
  float maks = get_val_max(input);
  float soft_sum = 0;
  for(float val:input) {
    soft_sum+=exp(val-maks);
  }
  float[] soft_arr = new float[input.length];
  for(int i = 0; i< input.length;i++) {
    soft_arr[i] = exp(input[i]-maks)/soft_sum;
  }
  return soft_arr;
}

float mean_square(float pred, float ans) {

  return pow((pred-ans),2.0);
}

float derived_mean_square(float pred, float ans) {

  return 2*(pred-ans);
}

float cross_entropy(float pred,float ans) {

    if(ans > 0.5) {
      return log(pred);
    }
    else {
      return log(1.0-pred);
    }
}

float derived_cross_entropy(float pred, float ans) {
  return (pred-ans);
}

float tanh(float x) {
  return (exp(x)-exp(-x))/ (exp(x)+exp(-x));
}
float derive_tanh(float x) {
  return (1-pow(tanh(x),2));
}
