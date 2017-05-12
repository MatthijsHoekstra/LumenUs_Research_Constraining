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

  private boolean amIBroken0 = false;
  private boolean amIBroken1 = false;

  ArrayList<GlitterEffect> glitterEffects = new ArrayList<GlitterEffect>();
  ArrayList<ExplosionEffect> explosionEffects = new ArrayList<ExplosionEffect>();

  boolean effectSide0 = false;
  boolean effectSide1 = false;

  Tube(int tubeNumber) {
    this.tubeNumber = tubeNumber; //0 - numTubes
    this.tubeModulus = tubeNumber % 3; // 0, 1, 2
    this.tripodNumber = tubeNumber / 3; //0 - numTubes / 3
  }

  //Event when tube is touched


  void isTouched(int touchLocation) {

    if (experimentNumberFinal == 1) {
      summon("random");
    } else if (experimentNumberFinal == 2) {
      for (int i = 0; i < EffectBlocks.size(); i++) {
        EffectBlock effectblocks = EffectBlocks.get(i);

        if (effectblocks.touchLocation == touchLocation) {
          EffectBlocks.remove(i);
          summon("random");

          createEffectBlock();
        }
      }
    } else if (experimentNumberFinal == 3) {
      for (int i = 0; i < EffectBlocks.size(); i++) {
        EffectBlock effectblocks = EffectBlocks.get(i);

        if (effectblocks.touchLocation == touchLocation) {
          EffectBlocks.remove(i);
          summon("random");

          createEffectBlock();
        }
      }
    }


    //if (touchLocation == 0 && effectSide0 == false) {
    //  EffectBlocks.add(new EffectBlock(tripodNumber, tubeModulus, 0, experimentNumber, false));

    //  effectSide0 = true;
    //}

    //if (touchLocation == 1 && effectSide1 == false) {
    //  EffectBlocks.add(new EffectBlock(tripodNumber, tubeModulus, 1, experimentNumber, false));

    //  effectSide1 = true;
    //}
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
    shutOffTheBroken();

    for (int i = 0; i < EffectBlocks.size(); i++) {
      EffectBlock effectblock = EffectBlocks.get(i);

      effectblock.display();

      if (effectblock.finished()) {
        EffectBlocks.remove(i);
        createEffectBlock();
      }
    }

    for (int i = glitterEffects.size() - 1; i >= 0; i--) {
      GlitterEffect glitterEffect = glitterEffects.get(i);

      glitterEffect.update();

      if (!glitterEffect.timeFinished()) {
        glitterEffect.generate();
      }

      if (glitterEffect.animationFinished()) {
        glitterEffects.remove(i);
      }
    }

    //for (int i = explosionEffects.size() - 1; i >= 0; i--) {
    //  ExplosionEffect explosionEffect = explosionEffects.get(i);

    //  explosionEffect.update();

    //  if (!explosionEffect.timeFinished()) {
    //    explosionEffect.generate();
    //  }

    //  if (explosionEffect.animationFinished()) {
    //    explosionEffects.remove(i);
    //  }
    //}
  }

  void addGlitter() {
    glitterEffects.add(new GlitterEffect(this.tubeModulus, this.tripodNumber));
  }

  void addExplosion() {
    explosionEffects.add(new ExplosionEffect(this.tubeModulus, this.tripodNumber));
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
    }
  }

  void summon(String effectToSummon) {

    if (effectToSummon.equals("random") == true) {
      println("pieuw pieuw mooi effect");
    }

    if (effectToSummon.equals("random") == true) {
      println("pieuw pieuw mooi effect");
    }
  }
}