abstract class Window extends DynamicFrame implements ButtonListener{ 
  
  ArrayList bHolder;
  ArrayList mHolder;
  Styles st;
  
  Window(PVector aPos, PVector aSize, UISceneElement aParent){
    super(aPos, aSize, aParent);
    
    bHolder = new ArrayList();
    
    mHolder = new ArrayList();
    
    st = new Styles();
  }
  
  void renderElement(){
    super.renderElement();
    PVector p = getCurrentPos();
    PVector s = getCurrentSize();
    // render chrome
    fill(100, 100, 100, 100); // color for the chrome in the borders
    st.roundRect((int)p.x, (int)p.y, (int)s.x, (int)s.y, 10);
  }
  
  boolean isOver(TuioCursor tcur){
    PVector p = getCurrentPos();
    PVector s = getCurrentSize();
    return Collision.hitQuad(p, s, new PVector(tcur.getScreenX(width), tcur.getScreenY(height))); 
  }
  
  protected void addControlButton(Button aButton){
    aButton.addListener(this);
    bHolder.add(aButton);
  }
  
  protected void addMenu(Menu menu){
    mHolder.add(menu);
  }

  ArrayList getElementRArray(){
    return bHolder;
  }
  
  ArrayList getMenuStructure() {
    return mHolder;
  }
  
}
