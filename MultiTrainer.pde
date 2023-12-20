class MultiTrainer {
  Trainer[] trainers;
  float[][] answers;
  MultiTrainer(Trainer[] trainers) {
    this.trainers = trainers;
    this.answers = new float[trainers.length][0];
  }

  void run(int iteration) {
    if (iteration*cycle_out < iterations) {
      for (int t = 0; t< this.trainers.length; t++) {
        float train_val = trainers[t].train();
        this.answers[t] = (float[])append(this.answers[t], train_val);
      }
    }

    for (int a = 0; a< this.answers.length; a++) {
      for (int b = 0; b<this.answers[a].length; b++) {
        fill(this.trainers[a].col);
        circle(b*w_ratio, (100-this.answers[a][b])*h_ratio, 10);
        textAlign(CENTER);
        textSize(20);
        text(this.trainers[a].title, width-box_size/2, 100*a+30);
        textSize(60);
        text(this.answers[a][this.answers[a].length-1], width-box_size/2, 100*a+80);
      }
    }
  }
}
