import spout.*;
import controlP5.*;

//---------------------------------------------------------------------------------------------------
int experimentNumber = -1; //4 possible options
//Start number -1, because button start adds +1

boolean displayGreenTransition = true;

boolean startTimer = false;
int startTimeTimer;
int currentTimeTimer;

int totalTimeTimer = 60000;

String testGroupNumberString;
int testGroupNumber;

int opacityGreenTransition = 0;

boolean startExperiment = false;

int[][] brokenTubes = {{7,18, 0, 0, 6, 6, 5}, {1, 1, 0, 1, 0, 1, 0}};
//---------------------------------------------------------------------------------------------------

int numTripods = 24;
int numTubes = numTripods * 3;
int numLEDsPerTube = 56;

int rectWidth = 9;
int rectHeight = 8;
int tubeLength = rectWidth * numLEDsPerTube;

int x;
int y;

int selectedTube, tubeNumber;

Tube[] tubes = new Tube[numTubes];

Spout spout;

ControlP5 cp5;

void setup() {
  size(1600, 880, OPENGL);
  frameRate(60);
  background(0);
  noStroke();
  noSmooth();

  for (int i=0; i< numTubes; i++) {
    tubes[i] = new Tube(i);
  }
  
  addButtonsOnScreen();
  
  brokenTubes();

  //drawRaster(); // drawRaster helps us with the LED mapping in ELM

  // Setup MQTT

  //client = new MQTTClient(this);
  //client.connect("mqtt://10.0.0.1", "processing");
  ////client.subscribe("tripods/" + 0 + "/tube/" + 0 + "/side/" + 0);

  //for (int i = 0; i < numTripods; i++) {
  //  for (int j = 0; j < 3; j++) {
  //    for (int k = 0; k < 2; k++) {
  //      //println(
  //      client.subscribe("tripods/" + i + "/tube/" + j + "/side/" + k);
  //    }
  //  }
  //}


  spout = new Spout(this);
}

void draw() {

  background(0);

  for (int i=0; i<numTubes; i++) {
    tubes[i].update();
  }

  ShowFrameRate();

  selectingSystem();

  drawRaster();

  spout.sendTexture();
}

void keyPressed() {

  int tubeNumber = currentSelectedTube + currentSelectedTripod * 3;

  //Selecting system for adding objects
  if (key == CODED) {
    if (keyCode == LEFT) {
      currentSelectedTube --;
    }
    if (keyCode == RIGHT) {
      currentSelectedTube ++;
    }
    if (keyCode == UP) {
      currentSelectedTripod --;
    }
    if (keyCode == DOWN) {
      currentSelectedTripod ++;
    }
  }

  if (key == 'a') {
    for (int i=0; i<numTubes; i++) {
      tubes[i].isTouched(0);
      tubes[i].isTouched(1);
    }
  }

  if (key == 's') {
    for (int i=0; i<numTubes; i++) {
      tubes[i].isUnTouched(0);
      tubes[i].isUnTouched(1);
    }
  }

  if (key == 'q') {
    tubes[tubeNumber].isTouched(0);
  }

  if (key == 'w') {
    tubes[tubeNumber].isTouched(1);
  }
}

//Simulating the sensor input 0 - released

void keyReleased() {
  int tubeNumber = currentSelectedTube + currentSelectedTripod * 3;

  if (key == 'q') {
    tubes[tubeNumber].isUnTouched(0);
  }

  if (key == 'w') {
    tubes[tubeNumber].isUnTouched(1);
  }
}