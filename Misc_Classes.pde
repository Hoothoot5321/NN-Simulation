class InputSvarHolder {

  float[][] test_input;
  float[][] test_svar;

  float[][] train_input;
  float[][] train_svar;

  InputSvarHolder(float[][] test_input, float[][] test_svar, float[][] train_input, float[][] train_svar) {
    this.test_input = test_input;
    this.test_svar = test_svar;
    this.train_input = train_input;
    this.train_svar = train_svar;
  }
  InputSvarHolder(float[][][] loaded) {
    this.test_input = loaded[0];
    this.test_svar = loaded[1];
    this.train_input = loaded[2];
    this.train_svar = loaded[3];
  }
}

class FeedOut {

    float[] output;
    float[][] activated;
    float[][] bases;
    
    FeedOut(float[] output, float[][] activated,float[][] bases) {
      this.output = output;
      this.activated = activated;
      this.bases = bases;
    }
}

class Setting {

  int layers;
  int neurons;
  float learning_rate;
  String test_file;
  String train_file;
  String title;
  float r;
  float g;
  float b;
  boolean training_acc;
  String act_f;
  boolean softmax;
  Setting(JSONObject json) {
         this.layers = json.getInt("layers");
         this.neurons = json.getInt("neurons");
         this.learning_rate = json.getFloat("learning_rate");
         this.test_file = json.getString("test_file");
         this.train_file = json.getString("train_file");
         this.title = json.getString("title");
         this.r = json.getFloat("r");
         this.g = json.getFloat("g");
         this.b = json.getFloat("b");
         this.training_acc = json.getBoolean("training_acc");
         this.act_f = json.getString("act_f");
         this.softmax = json.getBoolean("softmax");
  }
  
}
