class Network {

  Neuron[][] layers;
  float learning_rate;
  Act_func act_f;
  boolean softmax;

  Network(Neuron[][] layers, float learning_rate, Act_func act_f, boolean softmax) {
    this.layers = layers;
    this.learning_rate = learning_rate;
    this.act_f = act_f;
    this.softmax = softmax;
  }

  FeedOut feedforward(float[] input) {
    float[] data = new float[input.length];
    float[] temp_data = new float[0];
    arrayCopy(input, data);
    float[][] activated = new float[0][];
    float[][] bases = new float[0][];

    for (int layer_n = 0; layer_n<this.layers.length; layer_n++) {

      float[] temp_activs = new float[0];
      float[] temp_bases = new float[0];

      for (Neuron neuron : this.layers[layer_n]) {

        float base_out = neuron.feedforward(data);
        temp_bases = append(temp_bases, base_out);
        if (layer_n != this.layers.length-1) {
          float activ_out = this.act_f.a(base_out);
          temp_data = append(temp_data, activ_out);
          temp_activs = append(temp_activs, activ_out);
        } else {
          float activ_out;
          if (this.softmax) {
            activ_out = base_out;
          } else {
            activ_out = this.act_f.a(base_out);
          }

          temp_data = append(temp_data, activ_out);
          temp_activs = append(temp_activs, activ_out);
        }
      }
      data = new float[temp_data.length];
      arrayCopy(temp_data, data);
      if (layer_n != this.layers.length-1) {
        temp_data = new float[0];
      }
      bases = (float[][])append(bases, temp_bases);
      activated = (float[][])append(activated, temp_activs);
    }
    float[] out_data;
    if (this.softmax) {
      out_data= safe_softmax(data);
    } else {
      out_data = new float[data.length]; 
      arrayCopy(data,out_data);
    }

    FeedOut out = new FeedOut(out_data, activated, bases);
    return out;
  }
  void backprop(float[] kost, float[] input, float[][] activs, float[][] bases ) {
    float[][] temp_to_next = new float[0][0];
    for (int layer_n = this.layers.length-1; layer_n > -1; layer_n--) {
      float[][] to_next = new float[temp_to_next.length][0];
      arrayCopy(temp_to_next, to_next);
      if (layer_n != 0) {
        temp_to_next = new float[this.layers[layer_n][0].weights.length][0];
      }
      for (int neu_n = 0; neu_n<this.layers[layer_n].length; neu_n++) {
        float derived_out;
        float err = 0.0;
        if (layer_n == this.layers.length-1) {
          if (this.softmax) {
            derived_out = 1.0;
          } else {
            derived_out = this.act_f.d(bases[layer_n][neu_n]);
          }

          err = kost[neu_n];
        } else {
          derived_out = this.act_f.d(bases[layer_n][neu_n]);
          for (float val : to_next[neu_n]) {
            err+= val;
          }
        }
        for (int weight_n = 0; weight_n < this.layers[layer_n][neu_n].weights.length; weight_n++) {
          float cur_weight = this.layers[layer_n][neu_n].weights[weight_n];

          float to_next_val = cur_weight*err*derived_out;

          float pre;
          if (layer_n != 0) {

            temp_to_next[weight_n] = append(temp_to_next[weight_n], to_next_val);
            pre = activs[layer_n-1][weight_n];
          } else {
            pre = input[weight_n];
          }
          float change = pre*derived_out;
          this.layers[layer_n][neu_n].weights[weight_n]=cur_weight-(this.learning_rate*err*change);
          /*
          if (weight_n == 0 && neu_n == 0 && layer_n == 0) {
           println("Pre: ",pre);
           println("Change :",change);
           println("Err : ", err);
           println("Weight: ",this.layers[layer_n][neu_n].weights[weight_n]);
           
           }
           */
        }
        float cur_bias =  this.layers[layer_n][neu_n].bias;
        this.layers[layer_n][neu_n].bias=cur_bias-(this.learning_rate*err*derived_out);
      }
    }
  }
}
