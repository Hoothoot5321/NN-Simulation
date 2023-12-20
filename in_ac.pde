interface Act_func {
  public float a(float X);
  public float d(float X);
};

Act_func sig_moid = new Act_func() {
  public float a(float X) {
    return sigmoid(X);
  };
  public float d(float X) {
    return derived_sigmoid(X);
  };
};

Act_func rel = new Act_func() {
  public float a(float X) {
    return relu(X);
  };
  public float d(float X) {
    return derived_relu(X);
  };
};

Act_func th = new Act_func() {
  public float a(float X) {
    return tanh(X);
  };
  public float d(float X) {
    return derive_tanh(X);
  };
};
