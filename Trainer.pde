class Trainer {

  Network netværk;
  InputSvarHolder holder;
  IntList rand_batch;
  int iterations;
  String title;
  color col;
  boolean training_acc;
  Trainer(InputSvarHolder holder, int layers, int neurons, float learning_rate, String title, color col, boolean training_acc, Act_func act_f,boolean softmax) {
    Neuron[][] all_layers = gen_all_layers(neurons, layers, holder.test_input[0].length, holder.test_svar[0].length);

    this.training_acc = training_acc;
    Network temp_netværk = new Network(all_layers, learning_rate, act_f,softmax);
    this.netværk = temp_netværk;
    this.col = col;
    this.holder = holder;
    IntList temp_bathc = new IntList();
    for (int i = 0; i< holder.train_svar.length; i++) {
      temp_bathc.append(i);
    }

    this.rand_batch = temp_bathc;
    this.iterations = cycle_out;
    this.title = title;
  }

  Trainer(Setting setting, InputSvarHolder holder) {
    Neuron[][] all_layers = gen_all_layers(setting.neurons, setting.layers, holder.test_input[0].length, holder.test_svar[0].length);

    this.training_acc = setting.training_acc;
    Act_func act_f;
    
    
    if ("sigmoid".equals(setting.act_f)) {
      act_f = sig_moid;
    } else if ("relu".equals(setting.act_f)) {
      act_f = rel;
    } else if ("tanh".equals(setting.act_f)) {
      act_f = th;
    } else {
      throw new RuntimeException("Ikke valid aktiverings funktion\nModtog {"+setting.act_f+"}");
    }
    Network temp_netværk = new Network(all_layers, setting.learning_rate, act_f,setting.softmax);
    this.netværk = temp_netværk;
    this.col = color(setting.r, setting.g, setting.b);
    this.holder = holder;
    IntList temp_bathc = new IntList();
    for (int i = 0; i< holder.train_svar.length; i++) {
      temp_bathc.append(i);
    }

    this.rand_batch = temp_bathc;
    this.iterations = cycle_out;
    this.title = setting.title;
  }

  float train() {
    return start_training(this.netværk, this.holder, this.iterations, this.rand_batch, this.training_acc);
  }
}
