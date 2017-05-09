/* The Lighteffect class is the mediator of the entire code
 lighteffect.update is the only function that is CONSTANTLY running
 .update checks the tubes that are active, decides what light-effect they should show and exectues the corrosponding functions
 */

//import toxi.util.events.*;

class Tube {
  private int tubeNumber;
  private int tubeModulus;
  private int tripodNumber;

  private boolean amIBroken0 = false;
  private boolean amIBroken1 = false;

  ArrayList<Block> blocks = new ArrayList<Block>();

  boolean effectSide0 = false;
  boolean effectSide1 = false;

  Tube(int tubeNumber) {
    this.tubeNumber = tubeNumber; //0 - numTubes
    this.tubeModulus = tubeNumber % 3; // 0, 1, 2
    this.tripodNumber = tubeNumber / 3; //0 - numTubes / 3
  }

  //Event when tube is touched

  void isTouched(int touchLocation) {
    if (touchLocation == 0 && effectSide0 == false) {
      blocks.add(new Block(tubeModulus, tripodNumber, 0));

      effectSide0 = true;
    }

    if (touchLocation == 1 && effectSide1 == false) {
      blocks.add(new Block(tubeModulus, tripodNumber, 1));

      effectSide1 = true;
    }
  }

  //Event when tube is released

  void isUnTouched(int touchLocation) {
    for (int i = 0; i < blocks.size(); i++) {
      Block block = blocks.get(i);

      if (block.touchLocation == touchLocation) {
        blocks.remove(i);

        if (touchLocation == 0) {
          effectSide0 = false;
        }
        if (touchLocation == 1) {
          effectSide1 = false;
        }
      }
    }
  }

  // Executed every frame, for updating continiously things
  void update() {
    shutOffTheBroken();

    for (int i = 0; i < blocks.size(); i++) {
      Block block = blocks.get(i);

      block.display();
    }
  }

  void shutOffTheBroken() {
    if (amIBroken0 == true || amIBroken1 == true) {
      pushMatrix();
      translate(tubeModulus * (numLEDsPerTube * rectWidth) + (tubeModulus * 20 + 20), tripodNumber * 21 + 21); 
      pushStyle();
      noStroke();
      fill(255, 0, 0);
      if (amIBroken0 == true) {
        rect((tubeLength/2)*0, 0, tubeLength/2, rectHeight);
      }
      if (amIBroken1 == true) {
        rect((tubeLength/2)*1, 0, tubeLength/2, rectHeight);
      }
      popStyle();
      popMatrix();
      
      print("HET WERKT: ", amIBroken0, amIBroken1);
    }
  }
}