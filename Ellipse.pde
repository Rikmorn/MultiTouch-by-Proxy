class Ellipse extends DynamicFrame {
  
  Ellipse(PVector aPos, PVector aSize, UISceneElement aParent){
    super(aPos, aSize, aParent);
  }
  
  boolean isOver(TuioCursor tcur){
    PVector p = getCurrentPos();
    PVector s = getCurrentSize();
    return Collision.hitEllipse(p, s, new PVector(tcur.getScreenX(width), tcur.getScreenY(height)));    
  }
  
  void updateElement(){} 
  
  void renderElement(){
    super.renderElement();
    
    fill(204, 102, 0);
    PVector p = getCurrentPos();
    PVector s = getCurrentSize();
    ellipse((int)p.x, (int)p.y, (int)s.x, (int)s.y);
  }
  
  ArrayList getElementRArray(){
    return new ArrayList(); // doesn't have any
  }
  
  ArrayList getMenuStructure() {
    return new ArrayList(); // doesn't have any
  }
  
}

