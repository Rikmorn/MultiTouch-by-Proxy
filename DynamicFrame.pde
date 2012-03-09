// create and manage a movable and resizable frame
// calculations are all based on distance calculations with cursors

abstract class DynamicFrame implements UIFrameElement{
  
  PVector aIPosition;
  PVector aISize;
  PVector aCPosition;
  PVector aCSize;
  PVector aSceneDelta;
  ArrayList boundCursors;
  Scaler aScaler;
  
  boolean active, updDelta;
  
  boolean isSizable;
  
  ArrayList childElements;
  
  UISceneElement _Parent;

  DynamicFrame(PVector aPos, PVector aSize, UISceneElement aParent){
    
    aIPosition = aPos;
    aISize = aSize;
    
    aCPosition = new PVector(aIPosition.x, aIPosition.y);
    aCSize = new PVector(aISize.x, aISize.y);
    
    boundCursors = new ArrayList();
    active = false;
    updDelta = true;
    
    isSizable = true;
    
    childElements = new ArrayList();
    
    _Parent = aParent;
  }
  
  //******************* From BindableUIElement ****************************************************
  
  boolean bindCursor(TuioCursor aTcur){
    PVector p = getCurrentPos();
    PVector s = getCurrentSize();

    for (int i = 0; i < childElements.size(); ++i){
      BindableUIElement e = (BindableUIElement)childElements.get(i);
      if (e.bindCursor(aTcur)){
        return true;
      }
    }
    
    if (!isOver(aTcur)) return false;
    
    if (addCursor(aTcur)) {
      return true;
    }
    return false;
  }
  
  boolean unbindCursor(TuioCursor aTcur){
    for (int i = 0; i < childElements.size(); ++i){
      BindableUIElement e = (BindableUIElement)childElements.get(i);
      if (e.unbindCursor(aTcur)){
        return true;
      }
    }
    return (removeCursor(aTcur)) ? true : false;
  }
  
  void updateCursor(TuioCursor aTcur){ //update children, nothing to here in this method
    for (int i = 0; i < childElements.size(); ++i){
      BindableUIElement e = (BindableUIElement)childElements.get(i);
      e.updateCursor(aTcur);
    }
    updateFrame();
  }
  
  //******************* From UIElement ****************************************************
  
  void addChild(UIElement aChild){
    childElements.add(aChild);
  }
  
  void renderElement(){
    for (int i = 0; i < childElements.size(); ++i){
      UIElement e = (UIElement)childElements.get(i);
      e.renderElement();
    }
    //renderShape(); just super, or make abstract method
  }
  
  void updateElement() {
    for (int i = 0; i < childElements.size(); ++i){
      UIElement e = (UIElement)childElements.get(i);
      e.updateElement();
    }
  }
  
  boolean isOver(TuioCursor tcur) {
    return Collision.hitQuad(getCurrentPos(), getCurrentSize(), new PVector(tcur.getScreenX(width), tcur.getScreenY(height)));   
  }
  
  void setElementPos(PVector nPos){
    aIPosition = nPos;
    aCPosition = new PVector(aIPosition.x, aIPosition.y);
  }
  
  void setElementSize(PVector nSize){
    aISize = nSize;
    aCSize = new PVector(aISize.x, aISize.y);
  }
  
  //ArrayList getElementRArray() {} no need for it here
  
  //********************* From UIFrameElement ********************************************************
  void elementTranslate(PVector aPos){
    if (!active){
      if (updDelta){
        aSceneDelta = new PVector(aPos.x, aPos.y);
        updDelta = false;
      }
      aCPosition = PVector.add(aIPosition, PVector.sub(aPos, aSceneDelta));
      
      for (int i = 0; i < childElements.size(); ++i){
        UIFrameElement e = (UIFrameElement)childElements.get(i);
        e.elementTranslate(aPos);
      }
      
    }
  }
  
  void elementReset(){
    if (!active){
      saveCoords();
      updDelta = true;
      
      for (int i = 0; i < childElements.size(); ++i){
        UIFrameElement e = (UIFrameElement)childElements.get(i);
        e.elementReset();
      }
      
    }
  }
  
  //*************************** Protected Aid Methods *********************************************
  
  protected PVector getCurrentPos(){
    return aCPosition;
  }
  
  protected PVector getCurrentSize(){
    return aCSize;
  }
  
  protected void sizableFrame(boolean flag){
    isSizable = flag;
  }
  
  //********************* Private Aid Methods ********************************************************
  private boolean addCursor(TuioCursor aTcur){
    if (boundCursors.size() == 2) return false; // don't bound more than 2 cursors
    boundCursors.add(new Cursor(aTcur));
    if (!active){
      saveCoords();
      active = true;
    }
    
    if (boundCursors.size() == 2){ // if we have two points we use the scaler
      Cursor cur = (Cursor) boundCursors.get(0);
      Cursor cur1 = (Cursor) boundCursors.get(1);
      aScaler = new Scaler(cur.getCurrentPosition(), cur1.getCurrentPosition());
      saveCoords();
    }
    
    return true;
  }
  
  private boolean removeCursor(TuioCursor aTcur){
    int s = boundCursors.size();
    for (int i = 0; i < s; ++i){
      Cursor cur = (Cursor) boundCursors.get(i);
      if (cur.checkID(aTcur)){
        
        boundCursors.remove(i);
        
        if (boundCursors.size() == 1){
          Cursor tcur = (Cursor) boundCursors.get(0);
          tcur.setInitialPos(tcur.getCurrentPosition());
          saveCoords();
        }

        if (boundCursors.size() == 0){
          saveCoords();
          active = false;
          updDelta = true;
        }
        
        return true; // ok
      }
    }
    
    return false; // no unbind
  }
  
  private void saveCoords(){
    aIPosition.set(aCPosition);
    aISize.set(aCSize);
  }
  
  private void updateFrame(){
    if (!active) return;
    
    Cursor cur = (Cursor) boundCursors.get(0);
    
    if (boundCursors.size() == 1){ // simple move
      aCPosition = PVector.add(aIPosition, cur.getDDistance());
    }
    
    if (boundCursors.size() == 2){ // scale
      Cursor cur1 = (Cursor) boundCursors.get(1);
      
      aScaler.setCurrentPos(cur.getCurrentPosition(), cur1.getCurrentPosition());
      
      aCPosition = PVector.add(aIPosition, aScaler.getDeltaOrigin());
      if (isSizable){
        aCSize = PVector.add(aISize, aScaler.getDeltaSize());
      }
      
    }
  }
  
}


