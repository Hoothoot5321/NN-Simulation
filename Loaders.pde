float[] one_hot_lab_num(int row_n, int max, Table csv_table) {
  float label = csv_table.getFloat(row_n, "Labels");
  float[] one_hotted = one_hot(label, max);
  return one_hotted;
}

float[][][] load_input_svar(String train_file, String test_file) {
  Table test_csv = loadTable(test_file, "header");

  int test_row_count = test_csv.getRowCount();
  int test_column_count = test_csv.getColumnCount();


  Table train_csv = loadTable(train_file, "header");

  int train_row_count = train_csv.getRowCount();

  int bogstav_max = floor(test_csv.getFloat(test_row_count-1, 0));

  float[][] test_svar = new float[test_row_count][bogstav_max+1];
  float[][] train_svar = new float[train_row_count][bogstav_max+1];

  float[][] test_input = new float[test_row_count][test_column_count-1];
  float[][] train_input = new float[train_row_count][train_csv.getColumnCount()-1];



  for (int row_n = 0; row_n< train_row_count; row_n++) {
    if (row_n < test_row_count) {
      test_svar[row_n] = one_hot_lab_num(row_n, bogstav_max, test_csv);
    }
    train_svar[row_n] = one_hot_lab_num(row_n, bogstav_max, train_csv);
    for (int col_n = 1; col_n < test_column_count; col_n++) {
      if (row_n < test_row_count) {
        test_input[row_n][col_n-1] = test_csv.getFloat(row_n,col_n);
      }
      train_input[row_n][col_n-1] = train_csv.getFloat(row_n,col_n);
    }
  }
  
  float[][][] out = {test_input,test_svar,train_input,train_svar};
  
  return out;
}

MultiTrainer load_settings(String setting_file) {

  JSONObject json = loadJSONObject(setting_file);
  iterations = json.getInt("iterations");
  batch_size = json.getInt("batch_size");
  b_r = json.getFloat("b_r");
  b_g = json.getFloat("b_g");
  b_b = json.getFloat("b_b");
  JSONArray neuron_settings = json.getJSONArray("neuron_settings");
  Trainer[] trainer_in = new Trainer[neuron_settings.size()];
  for(int i = 0; i< neuron_settings.size();i++) {
    JSONObject sett = neuron_settings.getJSONObject(i);
    Setting setting = new Setting(sett);
    float[][][] loaded_ins = load_input_svar(setting.train_file,setting.test_file);
    InputSvarHolder holder = new InputSvarHolder(loaded_ins);
    trainer_in[i] = new Trainer(setting,holder);
  }
  MultiTrainer out = new MultiTrainer(trainer_in);
  return out;
  
}
