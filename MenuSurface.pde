class MenuSurface implements UIElement, ButtonListener {
  
  PVector _Pos;
  PVector _Size;
  String _Title;
  int _ID;
  ArrayList _Children;
  Styles st;
  
  ArrayList _Cursors;
  
  UIMenuSurfaceListener _Listener;
  
  MenuSurface(String aTitle, int ID){
    _Pos = new PVector(595, 65); 
    _Size = new PVector(200,440);
    _Title = aTitle;
    _ID = ID;
    _Children = new ArrayList();
    st = new Styles();
    _Cursors = new ArrayList();
  }
  
  PVector getCurrentPos(){
    return _Pos;
  }
  
  PVector getCurrentSize(){
    return _Size;
  }
  
  void setListener(UIMenuSurfaceListener aListener){
    _Listener = aListener;
  }
  
  void setCursor(TuioCursor acur){
    if (!_Cursors.contains(acur)){
      _Cursors.add(acur);
    }
  }
  
  void removeCursor(TuioCursor acur){
    for (int j = 0; j< _Children.size(); ++j){
      UIButtonElement c = (UIButtonElement) _Children.get(j);
      if (c.isOver(acur)) {
         c.onCursorRelease();
         c.deactivate();
      }
    }
    _Cursors.remove(acur);
  }
  
  void addButtonChild(Button aChild){
    aChild.setElementPos(new PVector (_Pos.x + 30, _Pos.y + (100 * _Children.size()) + 5));
    aChild.setElementSize(new PVector (_Size.x - 30, 50));
    aChild.addListener(this);
    _Children.add(aChild);
  }
  
  /*********** from button listener ********************/
  
  void onOver(int ID){}
  
  void onRelease(int ID){
    _Listener.onChoice(_ID, ID);
  }
  
  void onClick(int ID){ }
  
  /********* fomr UIElement ***********************/  
  void addChild(UIElement aChild){
    //_Children.add(aChild);
  }
  
  void renderElement(){
    PVector p = getCurrentPos();
    PVector s = getCurrentSize();
    fill(100, 100, 100, 100); // color for the chrome in the borders
    st.roundRect((int)p.x, (int)p.y, (int)s.x, (int)s.y, 10);
    for (int i = 0; i< _Children.size(); ++i){
      UIElement c = (UIElement) _Children.get(i);
      c.renderElement();
    }
  }
  
  void updateElement(){
    boolean over = false;
    for (int i = 0; i < _Cursors.size(); ++i){
      TuioCursor p = (TuioCursor) _Cursors.get(i);
      for (int j = 0; j< _Children.size(); ++j){
        UIButtonElement c = (UIButtonElement) _Children.get(j);
        if (c.isOver(p)) {
          c.onCursorOver();
          c.updateElement();
          //over = true;
        } else {
          //if (!over)
            c.deactivate();
        }
      }
    }
  }
  
  boolean isOver(TuioCursor tcur){
    PVector p = getCurrentPos();
    PVector s = getCurrentSize();
    return Collision.hitQuad(p, s, new PVector(tcur.getScreenX(width), tcur.getScreenY(height)));  
  } 

  ArrayList getElementRArray(){
    return new ArrayList();
  }
  
  ArrayList getMenuStructure(){
    return new ArrayList();
  }
  
  void setElementPos(PVector nPos){
    _Pos = nPos;
  }
  
  void setElementSize(PVector nSize){
    _Size = nSize;
  }
}
