class DBZ {
  int tubeModulus, tripodNumber;
  private int startTime, time, interTime, endTime;

  purpleRect p;
  blueRect b;
  sinRect s;
  whiteRect w;

  DBZ (int tubeModulus, int tripodNumber) {
    this.tubeModulus = tubeModulus;
    this.tripodNumber = tripodNumber;

    p = new purpleRect();
    b = new blueRect();
    s = new sinRect();
    w = new whiteRect();

    startTime = millis();
    interTime = startTime+1000;
    endTime = startTime+4000;
  }
  
    boolean timeFinished() {
    if (millis() > endTime) {
      return true;
    } else {
      return false;
    }
  }

  void update() {

    time = millis()-startTime;

    pushMatrix();
    translate(this.tubeModulus * (numLEDsPerTube * rectWidth) + (this.tubeModulus * 20 + 20), this.tripodNumber * 21 + 21);

    if (millis() < endTime) {
      p.update();
      b.update();
    }

    if (time >= interTime && time <= endTime) {
      s.update();
    }
    if (time >= 3500 && time <= endTime) {
      w.update();
    }
    
    popMatrix();
  }


  class blueRect {
    int startTime; // start time
    int interTime; // filling time
    int endTime; // end of animation

    blueRect() {
      startTime = millis();
      interTime = startTime+1000; // 1 second to fill
      endTime = 4000; // total animation time of 4 seconds
    }

    void update() {
      noStroke();
      fill (0, 0, 255);
      if (millis() <= startTime + endTime) {
        float currentTime = map (millis(), startTime, interTime, 0, tubeLength/2);
        rect(0, 0, currentTime, rectHeight);
      }
    }
  }

  class purpleRect {
    int startTime; // start time
    int interTime; // filling time
    int endTime; // end of animation

    purpleRect() {
      startTime = millis();
      interTime = startTime+1000; // 1 second to fill
      endTime = 4000; // total animation time of 4 seconds
    }

    void update() {
      noStroke();
      fill (255, 0, 255);
      if (millis() <= startTime + endTime) {
        float currentTime = map (millis(), startTime, interTime, 0, -tubeLength/2);
        rect(tubeLength, 0, currentTime, rectHeight);
      }
    }
  }

  class sinRect {
    int startTime;
    int interTime;
    int endTime; 

    float sinLength;
    float a;

    sinRect() {
      startTime = millis();
      interTime = startTime+1000; // 1 second to fill
      endTime = startTime+3500; // total animation time of 4 seconds
    }

    void update() {
      noStroke();
      a = map(millis(), 0, 1000, 0, PI/2);
      sinLength = (tubeLength/4)*sin(a);

      if (sinLength <= 0) {
        fill(255, 0, 255);
      } else if (sinLength >= 0) {
        fill(0, 0, 255);
      }

      if (millis() < endTime) {
        rect(tubeLength/2, 0, sinLength, rectHeight);
      }
    }
  }

  class whiteRect {
    int startTime;
    int interTime;
    int endTime;

    float x;
    float x2;

    whiteRect() {
      startTime = millis();
      interTime = startTime+1000;
      endTime = 4000;
    }

    void update () {
      noStroke();
      fill(255);

      x = map(millis()-startTime, 3500, 4000, 0, 20);
      x2 = sq(x);

      rect(tubeLength/2, 0, x2, rectHeight);
      rect(tubeLength/2, 0, -x2, rectHeight);
    }
  }
  
  boolean finished() {
    if (millis() > endTime) {
      return true;
    } else {
      return false;
    }
  }
}