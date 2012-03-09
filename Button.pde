abstract class Button implements UIButtonElement{
  
  ArrayList _BListeners;
  boolean _active;
  PVector _Pos, _Size;
  int _ID;
  
  PImage _back;
  
  Button (PVector aPos, PVector aSize, int ID, String imagePath){
    _Pos = aPos;
    _Size = aSize;
    _active = false;
    _ID = ID;
    _BListeners = new ArrayList();
    
    if (!imagePath.equals("")){
      _back = loadImage(imagePath);
      _back.resize((int) _Size.x, (int) _Size.y);
    }
  }
  
  Button (int ID, String imagePath){
    _active = false;
    _ID = ID;
    _BListeners = new ArrayList();
    
    if (!imagePath.equals("")){
      _back = loadImage(imagePath);
    }
  }

  void addListener(ButtonListener aListener){
    _BListeners.add(aListener);
  }
  
  PVector getPosition(){
    return _Pos;
  }
  
  PVector getSize(){
    return _Size;
  }
  
  boolean hasBackground(){
    return (_back != null) ? true : false;
  }

  /************* from UIButtonElement ***************************/
  
  void onCursorOver(){
    _active = true;
    publishOnOver();
  }
    
  void onCursorRelease(){
    _active = false;
    // we check for click here
    publishOnRelease();
  }
   
  boolean isActive(){
    return _active;
  }
  
  void deactivate(){
    _active = false;
  }
  
  void setElementPos(PVector nPos){
    _Pos = nPos;
  }
  
  void setElementSize(PVector nSize){
    _Size = nSize;
    if (hasBackground()){
      _back.resize((int) _Size.x, (int) _Size.y);
    }
  }
  
  /************* from UIElement ***************************/
  
  void addChild(UIElement aChild){} // eventual labels, imagens, etc
  
  // these can go to the children
  //void renderElement();
  //void updateElement();
  //boolean isOver(TuioCursor tcur);
  
  ArrayList getElementRArray(){
    return new ArrayList();
  }
  
  ArrayList getMenuStructure() {
    return null;
  }
  
  void publishOnRelease(){
    for (int i = 0; i < _BListeners.size(); ++i){
      ButtonListener bl = (ButtonListener) _BListeners.get(i);
      bl.onRelease(_ID);
    }
  }
  
  void publishOnOver(){
    for (int i = 0; i < _BListeners.size(); ++i){
      ButtonListener bl = (ButtonListener) _BListeners.get(i);
      bl.onOver(_ID);
    }
  }
  
  void publishClick(){
    for (int i = 0; i < _BListeners.size(); ++i){
      ButtonListener bl = (ButtonListener) _BListeners.get(i);
      bl.onClick(_ID);
    }
  }
  
}


