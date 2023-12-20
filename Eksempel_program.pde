String setting_file = "Setting/settings.json";

float h_ratio;
float w_ratio;

int iterations = 0;
int iteration = 0;
int cycle_out = 10;


MultiTrainer main_trainer;
boolean err = false;
String err_text;

float b_r = 255;
float b_g = 255;
float b_b = 255;

int box_size = 300;
void setup() {
  size(1280, 720);
  try {
    main_trainer = load_settings(setting_file);
  }
  catch(RuntimeException e) {
    err_text = e.getMessage();
    err = true;
  }

  h_ratio = float(height)/100.0;
  w_ratio = float(width-box_size)/(iterations/cycle_out);

  noStroke();
}

void draw() {
  background(b_r,b_g,b_b);
  fill(125);
  if (!err) {
    rect(width-box_size, 0, box_size, height);
    main_trainer.run(iteration);
    iteration+=1;
  } else {
    textSize(40);
    textAlign(CENTER);
    text(err_text, width/2, height/2);
    textSize(30);
    text("Prøv at checkke om settings.json er stillet ordentligt op", width/2, height/2+120);
  }
}
