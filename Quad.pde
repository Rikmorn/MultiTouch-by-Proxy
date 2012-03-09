class Quad extends DynamicFrame {
  
  Quad(PVector aPos, PVector aSize, UISceneElement aParent){
    super(aPos, aSize, aParent);
  }
  
  boolean isOver(TuioCursor tcur){
    PVector p = getCurrentPos();
    PVector s = getCurrentSize();
    return Collision.hitQuad(p, s, new PVector(tcur.getScreenX(width), tcur.getScreenY(height)));   
  }
  
  void updateElement(){}
  
  void renderElement(){
    super.renderElement();
    
    fill(204, 102, 0);
    PVector p = getCurrentPos();
    PVector s = getCurrentSize();
    rect((int)p.x, (int)p.y, (int)s.x, (int)s.y);
  }
  
  ArrayList getElementRArray(){ // doens't have any
    return new ArrayList();
  }
  
  ArrayList getMenuStructure() {
    return new ArrayList();
  }
  
}
