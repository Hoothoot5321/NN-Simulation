float start_training(Network netværk, InputSvarHolder holder, int iterations, IntList rand_batch, boolean training_acc) {
  int answer_amount = holder.test_svar[0].length;
  int input_amount = holder.test_input[0].length;

  for (int iteration = 0; iteration< iterations; iteration++) {

    float[] full_kost = new float[answer_amount];
    float[][] full_activated = new float[0][0];
    float[][] full_bases = new float[0][0];
    float[] full_inputs = new float[input_amount];

    rand_batch.shuffle();
    for (int temp_l = 0; temp_l < netværk.layers.length; temp_l++) {
      float[] temp_vec1 = new float[netværk.layers[temp_l].length];
      float[] temp_vec2 = new float[netværk.layers[temp_l].length];
      full_activated = (float[][])append(full_activated, temp_vec1);
      full_bases = (float[][])append(full_activated, temp_vec2);
    }

    for (int batch = 0; batch < batch_size; batch++) {
      float[] answer = holder.train_svar[rand_batch.get(batch)];
      float[] input = holder.train_input[rand_batch.get(batch)];

      FeedOut output = netværk.feedforward(input);
      float[] predictions = output.output;

      for (int pred_n = 0; pred_n<predictions.length; pred_n++) {
        float kost = derived_cross_entropy(predictions[pred_n], answer[pred_n]);
        full_kost[pred_n]+=kost/f_batch_size;
      }
      for (int i = 0; i< input.length; i++) {
        full_inputs[i]+=input[i]/f_batch_size;
      }
      float[][] activated = output.activated;
      float[][] base = output.bases;

      for (int a = 0; a<activated.length; a++) {
        for (int b = 0; b<activated[a].length; b++) {
          full_activated[a][b]+=activated[a][b]/f_batch_size;
          full_bases[a][b]+=base[a][b]/f_batch_size;
        }
      }
    }

    netværk.backprop(full_kost, full_inputs, full_activated, full_bases);
  }

  float amount_right = 0;
  float f_in_length;
  if (!training_acc) {
    f_in_length = float(holder.test_input.length);
    for (int i = 0; i< holder.test_input.length; i++) {
      FeedOut output_test = netværk.feedforward(holder.test_input[i]);
      float[] predictions2 = output_test.output;

      int ind_ans = get_ind_max(holder.test_svar[i]);
      int pred_ind = get_ind_max(predictions2);
      if (ind_ans == pred_ind) {
        amount_right+=1.0;
      }
    }
  } else {
    f_in_length = float(holder.train_input.length);
    for (int i = 0; i< holder.train_input.length; i++) {
      FeedOut output_test = netværk.feedforward(holder.train_input[i]);
      float[] predictions2 = output_test.output;

      int ind_ans = get_ind_max(holder.train_svar[i]);
      int pred_ind = get_ind_max(predictions2);
      if (ind_ans == pred_ind) {
        amount_right+=1.0;
      }
    }
  }

  float proc_right = (amount_right/f_in_length)*100.0;
  return proc_right;
}
