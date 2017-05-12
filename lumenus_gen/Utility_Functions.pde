// utility functions like drawRaster and showFrameRate

void drawRaster() {
  pushStyle();
  noFill();
  stroke(0, 102, 153);

  pushMatrix();
  translate(20, 21);  

  for (int j = 0; j < numTripods; j ++) {
    for (int i = 0; i < numLEDsPerTube; i ++) {
      rect(x, y, rectWidth, rectHeight);
      x += rectWidth;
    }

    x += 20;

    for (int i = 0; i < numLEDsPerTube; i ++) {
      rect(x, y, rectWidth, rectHeight);
      x += rectWidth;
    }

    x += 20;

    for (int i = 0; i < numLEDsPerTube; i ++) {
      rect(x, y, rectWidth, rectHeight);
      x += rectWidth;
    }
    x = 0;
    y += 21;
  }

  x = 0;
  y = 0;
  popMatrix();
  popStyle();
}

void ShowFrameRate() {
  pushStyle();
  fill(200);
  text(int(frameRate) + " " + currentSelectedTripod + " " + currentSelectedTube +  " // Current time experiment: " + currentTimeTimer + " // Current experiment: " + (experimentNumber + 1), 100, height - 250);
  popStyle();
}

int currentSelectedTube = 0;
int currentSelectedTripod = 0;

void selectingSystem() {
  //Keep selecting system within raster
  if (currentSelectedTube < 0) {
    currentSelectedTube = 0;
  }
  if (currentSelectedTube > 2) {
    currentSelectedTube = 2;
  }
  if (currentSelectedTripod < 0) {
    currentSelectedTripod = 0;
  }
  if (currentSelectedTripod >= numTripods) {
    currentSelectedTripod = numTripods - 1;
  }

  //Create rectangle for indicating which tube / tripod is selected
  pushMatrix();
  translate(currentSelectedTube * (numLEDsPerTube * rectWidth) + (currentSelectedTube * 20 + 20), currentSelectedTripod * 21 + 21); 

  pushStyle();
  noFill();

  stroke(0, 255, 0);
  rect(x-5, y-5, tubeLength+8, rectHeight+9);

  popStyle();
  popMatrix();
}

void addButtonsOnScreen() {

  cp5 = new ControlP5(this);

  // knoppen
  //cp5.addButton("buttonEndGoalWhenAnimationFinished")
  //  .setValue(0)
  //  .setPosition(100, height-150)
  //  .setSize(200, 19)
  //  ;

  //cp5.addButton("buttonEndGoalWhenReleased")
  //  .setValue(0)
  //  .setPosition(350, height-150)
  //  .setSize(200, 19)
  //  ;

  // text input
  cp5.addTextfield("group")
    .setPosition(100, height-225)
    .setSize(100, 50)
    .setAutoClear(false);

  cp5.addBang("StartButtonPressed")
    .setPosition(100, height-150)
    .setSize(450, 50);
}


void StartButtonPressed() {
  testGroupNumberString = cp5.get(Textfield.class, "group").getText();

  println(testGroupNumberString);

  testGroupNumber = int(testGroupNumberString);

  experimentNumber ++;

  if (startExperiment == false) {
    startExperiment = true;
  }

  startTimer = true;
  inBetweenResearch = false;

  int randomTubeNumber = int(random(numTubes));

  tubes[randomTubeNumber].EffectBlocks.add(new EffectBlock(tubes[randomTubeNumber].tripodNumber, tubes[randomTubeNumber].tubeModulus, experimentNumber, int(round(random(1))), false));

  for (int i=0; i < 5; i++) {
    randomTubeNumber = int(random(numTubes));

    tubes[randomTubeNumber].EffectBlocks.add(new EffectBlock(tubes[randomTubeNumber].tripodNumber, tubes[randomTubeNumber].tubeModulus, experimentNumber, int(round(random(1))), true));
  }
  
  println("Start Experiment: " + experimentNumber);
}

void summonEffect(String effectToSummon, int tripodNumber, int tubeModulus, int sideTouched) {
  boolean effectAvailable = false;
  int tubeNumber = tripodNumber * 3 + tubeModulus;

  for (int i = 0; i > Effects.length; i++) {
    if (Effects[i].equals(effectToSummon) == true) {
      effectAvailable = true;
      break;
    }
  }

  if (effectAvailable) {
    tubes[tubeNumber].summon(effectToSummon);
  }
}