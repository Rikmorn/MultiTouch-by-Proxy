class Scene implements UISceneElement{ // manages applications and moves them at the same time if the user uses two fingers on it. 
  ArrayList boundCursors;
  
  Scaler aScaler;
  
  ArrayList childUIElements;
  
  FocusListener fListener;
  
  Scene(){
    boundCursors = new ArrayList();
    childUIElements = new ArrayList();
  }
  
  void sceneTranslate(PVector aPos){
    for (int i = 0; i < childUIElements.size(); ++i){
      UIFrameElement e = (UIFrameElement)childUIElements.get(i);
      e.elementTranslate(aPos);
    }
  }
  
  void sceneReset(){
    for (int i = 0; i < childUIElements.size(); ++i){
      UIFrameElement e = (UIFrameElement)childUIElements.get(i);
      e.elementReset();
    }
  }
  
  void addFocusListener(FocusListener aFL){
    fListener = aFL;
  }
  
  //******************* From BindableUIElement ****************************************************
  
  boolean bindCursor(TuioCursor aTcur){ 
    for (int i = 0; i < childUIElements.size(); ++i){
      BindableUIElement e = (BindableUIElement)childUIElements.get(i);
      if (e.bindCursor(aTcur)) {
        fListener.onFocusChange(e.getElementRArray(), e.getMenuStructure());
        childUIElements.add(0, childUIElements.remove(i)); // cute little hack
        return true;
      }
    }
    
    // if it doesn't bind with any children then it's to this element
    boundCursors.add(new Cursor(aTcur));
    
    if (boundCursors.size() == 2){
      Cursor cur = (Cursor) boundCursors.get(0);
      Cursor cur1 = (Cursor) boundCursors.get(1);
      aScaler = new Scaler(cur.getCurrentPosition(), cur1.getCurrentPosition());
    }
    return true;
  }
  
  boolean unbindCursor(TuioCursor aTcur){
    
    // if it doesn't unbind with any children then it's to this element, let's check the root first
    for (int i = 0; i<boundCursors.size(); ++i){
      Cursor cur = (Cursor) boundCursors.get(i);
      if (cur.checkID(aTcur)){
        boundCursors.remove(i);
        
        if (boundCursors.size() < 2){
          sceneReset();
        }
        
        return true;
      }
    }
    
    // try to unbind from the shapes, if not then unbind from scene
    for (int i = 0; i < childUIElements.size(); ++i){
      BindableUIElement e = (BindableUIElement)childUIElements.get(i);
      if (e.unbindCursor(aTcur)) {
        return true;
      }
    }
    
    return true;
  }
  
  void updateCursor(TuioCursor aTcur){
    for (int i = 0; i < childUIElements.size(); ++i){
      BindableUIElement e = (BindableUIElement)childUIElements.get(i);
      e.updateCursor(aTcur);
    }
    
    if (boundCursors.size() == 0) return; 

    if (boundCursors.size() == 2) {
      Cursor cur = (Cursor) boundCursors.get(0);
      Cursor cur1 = (Cursor) boundCursors.get(1);
      aScaler.setCurrentPos(cur.getCurrentPosition(), cur1.getCurrentPosition());
      sceneTranslate(aScaler.getDeltaOrigin());
    }
  }
  
  
  //******************* From UISceneElement ****************************************************
  
  void killChild(UIElement element){
    UIElement e = (UIElement) childUIElements.remove(childUIElements.indexOf(element));
    e = null;
    fListener.onFocusChange(new ArrayList(), new ArrayList());
    if (childUIElements.size() > 0){
      e = (UIElement) childUIElements.get(0);
      fListener.onFocusChange(e.getElementRArray(), e.getMenuStructure());
    }
  }
  
  //******************* From UIElement ****************************************************
  
  boolean isOver(TuioCursor tcur){ // check it cursor is over them
    return true; // tentative
  } 

  ArrayList getElementRArray() {
    return new ArrayList();
  } // so far scene does not have anything
  
  ArrayList getMenuStructure() {
    return null;
  }
  
  void addChild(UIElement aChild){
    childUIElements.add(aChild);
    fListener.onFocusChange(aChild.getElementRArray(), aChild.getMenuStructure());
  }
  
  void renderElement(){ 
    for (int i = childUIElements.size() - 1 ; i >= 0; --i){ // preserve z value
      UIElement e = (UIElement)childUIElements.get(i);
      e.renderElement();
    }
  }
  
  void updateElement(){
    for (int i = childUIElements.size() - 1 ; i >= 0; --i){ // preserve z value
      UIElement e = (UIElement)childUIElements.get(i);
      e.updateElement();
    }
  }
  
  void setElementPos(PVector nPos){}
  
  void setElementSize(PVector nSize){}
  
}

