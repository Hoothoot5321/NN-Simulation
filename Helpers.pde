float get_val_max(float[] arr) {
  float pre_val = -100.0;

  for (int i = 0; i< arr.length; i++) {
    if ( arr[i]> pre_val) {
      pre_val = arr[i];
    }
  }
  return pre_val;
}

int get_ind_max(float[] arr) {
  float pre_val = -100.0;
  int ind = 0;

  for (int i = 0; i< arr.length; i++) {
    if ( arr[i]> pre_val) {
      pre_val = arr[i];
      ind = i;
    }
  }
  return ind;
}


float[] one_hot(float answer, int amount) {
  int int_answer = floor(answer);
  float[] one_hot_arr = new float[amount+1];

  for (int i = 0; i< amount+1; i++) {
    if (i == int_answer) {
      one_hot_arr[i] = 1.0;
    }
  }

  return one_hot_arr;
}

float dot_arrs(float[] arr1, float[] arr2) {

  float sum = 0;

  for (int i = 0; i< arr1.length; i++) {
    float temp_sum = arr1[i]*arr2[i];
    sum+=temp_sum;
  }
  return sum;
}

Neuron[] gen_layer(int neurons, int weights) {
  Neuron[] layer = {};
  for (int neu_n = 0; neu_n<neurons; neu_n++) {
    float[] weight = {};
    float bias = random(-0.5, 0.5);
    for (int w_n = 0; w_n<weights; w_n++) {
      weight = append(weight, random(-0.5, 0.5));
    }
    Neuron neuron = new Neuron(weight, bias);
    layer = (Neuron[])append(layer, neuron);
  }
  return layer;
}

Neuron[][] gen_all_layers(int neurons, int layers, int input_amount, int output_amount) {
  Neuron[][] all_layers = new Neuron[0][0];
  for (int l_n = 0; l_n < layers; l_n++) {
    if (layers-1==0) {
      all_layers =(Neuron[][])append(all_layers, gen_layer(output_amount, input_amount));
    } else if (l_n==0) {
      all_layers = (Neuron[][])append(all_layers, gen_layer(neurons, input_amount));
    } else if (l_n==layers-1) {
      all_layers = (Neuron[][])append(all_layers, gen_layer(output_amount, neurons));
    } else {
      all_layers = (Neuron[][])append(all_layers, gen_layer(neurons, neurons));
    }
  }
  return all_layers;
}
