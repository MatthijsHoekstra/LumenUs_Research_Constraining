//Standard setup for a class

class Rainbow {

  int tubeModulus;
  int tripodNumber;
  int touchLocation;

  int startTime, livingTime;

  Rainbow(int tubeModulus, int tripodNumber, int touchLocation) {

    this.tubeModulus = tubeModulus;
    this.tripodNumber = tripodNumber;
    this.touchLocation = touchLocation;

    startTime = millis();
    livingTime = 3000;
  }

  boolean timeFinished() {
    if (millis() > startTime + livingTime) {
      return true;
    } else {
      return false;
    }
  }

  void display() {

    pushMatrix();
    translate(this.tubeModulus * (numLEDsPerTube * rectWidth) + (this.tubeModulus * 20 + 20), this.tripodNumber * 21 + 21);

    pushStyle();

    fill(255);

    if (this.touchLocation == 0) {
      rect(0, 0, tubeLength/2, rectHeight);
    }

    if (this.touchLocation == 1) {
      rect(tubeLength/2, 0, tubeLength/2, rectHeight);
    }

    popStyle();
    popMatrix();
  }
}

Class Rainbow_layers {

  int tubeModulus, tripodNumber;
  int startTime, livingTime;
  int fadeInTime;

  Rainbow_layers(int tubeModulus, int tripodNumber, float x) {
    this.tubeModulus = tubeModulus;
    this.tripodNumber = tripodNumber;
    this.x = x;

    startTime = millis();
  } 
  
  void update (){
    
    pushMatrix();
    translate(this.tubeModulus * (numLEDsPerTube * rectWidth) + (this.tubeModulus * 20 + 20), this.tripodNumber * 21 + 21);
    pushStyle();
    
    if (millis() < startTime + fadeInTime) {
      
      float currentTime = map(millis(), startTime, startTime + fadeInTime, 0, 1);
      float interValue = AULib.ease(AULib.EASE_IN_OUT_CUBIC, currentTime);
      float opacity = map(interValue, 0, 1, 0, 255);

      fill(randomColor, constrain(opacity, 0, 255));
      rect(x, 0, rectWidth, rectHeight);
    } else {

      float currentTime = map(millis(), startTime + fadeInTime, startTime + livingTime + fadeInTime, 0, 1);
      float interValue = AULib.ease(AULib.EASE_IN_OUT_CUBIC, currentTime);
      float opacity = map(interValue, 0, 1, 255, 0);

      fill(randomColor, constrain(opacity, 0, 255));
      rect(x, 0, rectWidth, rectHeight);
    }
    
    currentTime = 10;
    popStyle();
    popMatrix();
    