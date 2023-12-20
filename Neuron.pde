class Neuron {

  float[] weights;

  float bias;

  Neuron(float[] weights, float bias) {
    this.weights = weights;
    this.bias = bias;
  }
  
  float feedforward(float[] input) {

    float sum = dot_arrs(this.weights,input);
    return sum+this.bias;
  }
}
