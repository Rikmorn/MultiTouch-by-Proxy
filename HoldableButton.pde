class HoldableButton extends Button { // button that does something when held
  
  float time;
  boolean hold;
  String caption;
  
  HoldableButton(PVector aPos, PVector aSize, int ID, String aCaption, String imagePath){
    super(aPos, aSize, ID, imagePath);
    time = -1;
    hold = false;
    caption = aCaption;
  }
  
  HoldableButton(int ID, String aCaption, String imagePath){
    super(ID, imagePath);
    time = -1;
    hold = false;
    caption = aCaption;
  }

  void deactivate(){
    super.deactivate();
     hold = false;
     time = -1;
  }
  
  // the diference with this one is that we need to keep up with time and publish the onhold event to all listeners
  void updateElement(){
    if (time == -1){
      time = millis();
    }
    if (!hold && (millis() - time > 1000)){
      publishOnHold();
      hold = true;
    }
  }
  
  void renderElement(){ // no need for super
    PVector p = getPosition();
    PVector s = getSize();
    
    if (isActive()) {
        fill (255, 0, 0, 150);
      } else {
        fill(0, 0, 0, 150);
      }
    rect((int)p.x, (int)p.y, (int)s.x, (int)s.y);
    
    if (hasBackground()){
      image(_back, (int)p.x + 5, (int)p.y + 5, (int)s.x - 10, (int)s.y - 10);
    }
      
    fill (150);
    textAlign(CENTER, CENTER);
    text(caption, (int)p.x, (int)p.y, (int)s.x, (int)s.y);
  }
  
  boolean isOver(TuioCursor tcur){
    PVector p = getPosition();
    PVector s = getSize();
    return Collision.hitQuad(p, s, new PVector(tcur.getScreenX(width), tcur.getScreenY(height))); 
  }
  
  void publishOnHold(){
    for (int i = 0; i < _BListeners.size(); ++i){
        HoldableListener bl = (HoldableListener) _BListeners.get(i);
        bl.onHold(_ID);
      }
  }
  
  void publishOnRelease(){} // don't publish release events
  
}


