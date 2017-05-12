/* The Lighteffect class is the mediator of the entire code
 lighteffect.update is the only function that is CONSTANTLY running
 .update checks the tubes that are active, decides what light-effect they should show and exectues the corrosponding functions
 */

//import toxi.util.events.*;

class Tube {
  private int tubeNumber;
  private int tubeModulus;
  private int tripodNumber;

  ArrayList<Block> Blocks = new ArrayList<Block>();
  ArrayList<EffectBlock> EffectBlocks = new ArrayList<EffectBlock>();

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
      EffectBlocks.add(new EffectBlock(tripodNumber, tubeModulus, 0, experimentNumber, false));

      effectSide0 = true;
    }

    if (touchLocation == 1 && effectSide1 == false) {
      EffectBlocks.add(new EffectBlock(tripodNumber, tubeModulus, 1, experimentNumber, false));

      effectSide1 = true;
    }
  }

  //Event when tube is released

  void isUnTouched(int touchLocation) {
    //for (int i = 0; i < Blocks.size(); i++) {
    //  EffectBlock effectblock = EffectBlocks.get(i);

    //  if (effectblock.touchLocation == touchLocation) {
    //    EffectBlocks.remove(i);

    //    if (touchLocation == 0) {
    //      effectSide0 = false;
    //    }
    //    if (touchLocation == 1) {
    //      effectSide1 = false;
    //    }
    //  }
    //}
  }

  // Executed every frame, for updating continiously things
  void update() {

    for (int i = 0; i < EffectBlocks.size(); i++) {
      EffectBlock effectblock = EffectBlocks.get(i);

      effectblock.display();
      
      if (effectblock.finished()){
        EffectBlocks.remove(i);
        createEffectBlock();
      }
    }
  }
  
  void summon(String effectToSummon){
    
  }
}