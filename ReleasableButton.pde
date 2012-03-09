class ReleasableButton extends Button { // button that does something when released
  
  String caption;
  
  ReleasableButton(PVector aPos, PVector aSize, int ID, String aCaption, String imagePath){
    super(aPos, aSize, ID, imagePath);
    caption = aCaption;
  }
  
  ReleasableButton(int ID, String aCaption, String imagePath){
    super(ID, imagePath);
    caption = aCaption;
  }
  
  void updateElement(){} // nothing much
  
  void renderElement(){ // no need for super
    PVector p = getPosition();
    PVector s = getSize();
    
    if (isActive()) {
        fill (255, 255, 255, 150);
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
}


