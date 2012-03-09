class Menu implements ButtonListener, HoldableListener{ // most of this is upkeep for the particularities of updating interface elements
  
  ArrayList mChildren;
  boolean active;
  String _Name;
  PVector _Pos, _Size, _cPos;
  MenuListener _Listener;
  int _ID;
  
  HoldableButton activator;
  
  ArrayList _CurPos;
  
  ArrayList surfaceHolder;
  ArrayList HSrel;
  int activeSurfaceID;
  
  Menu(String aName, int ID){
    _Name = aName;
    _ID = ID;
    active = false;
    mChildren = new ArrayList();
    
    surfaceHolder = new ArrayList();
    HSrel = new ArrayList();
    activeSurfaceID = -1;
    
    _Size = new PVector(100,50);
    _Pos = new PVector(250,0);
    _cPos = new PVector(250,60);
    
    activator = new HoldableButton(_Pos, _Size, 0, aName, ""); // should be done for the initial button
    activator.addListener(this);
    HSrel.add(-1);
    
    _CurPos = new ArrayList();
  } 
  
  void addListener(MenuListener aL){
    _Listener = aL;
  }
  
  void setCursorPos(TuioCursor aPos){
    if (!_CurPos.contains(aPos)){
      _CurPos.add(aPos);
    }
    setActive(true);
  }
  
  void removeCursorPos(TuioCursor aPos){
    if (_CurPos.indexOf(aPos) == 0){
      setActive(false);
    }
    
    if (activeSurfaceID >= 0){
      for (int k = 0; k < surfaceHolder.size(); ++k){
        MenuSurface s = (MenuSurface) surfaceHolder.get(k);
        if (s.isOver(aPos)){
          s.removeCursor(aPos);
        }
      }
    }
    
    for (int j = 0; j < mChildren.size(); ++j){
      UIButtonElement e = (UIButtonElement)mChildren.get(j);
      if (e.isOver(aPos)) {
        e.onCursorRelease();
        e.deactivate();
      }
    }
    
    _CurPos.remove(aPos);
  }
  
  void addMenuSurface(MenuSurface aMS){
    surfaceHolder.add(aMS);
  }
  
  boolean isActive(){
    return active;
  }
  
  void setMenuButtonPos(PVector nPos){
    _Pos = nPos;
    activator.setElementPos(_Pos);
  }
  
  void setMenuButtonSize(PVector nSize){
    _Size = nSize;
    activator.setElementSize(_Size);
  }
  
  void updateCoords(){
    for (int i = 0; i < mChildren.size(); ++i){
      UIElement e = (UIElement) mChildren.get(i);
      e.setElementPos(new PVector (_Pos.x, _Pos.y + (50 * (i + 1)) ));
      e.setElementSize(new PVector (_Size.x, _Size.y));
    }
  }
    
  
  /*********************** from UIElement ***************************/
  
  void addChild(UIElement aChild){ 
    //mChildren.add(aChild);
  }
  
  void addHoldable(int surfaceID, String aCaption){
    HoldableButton h = new HoldableButton(mChildren.size() + 1, aCaption, ""); // should be done for the initial button
    h.addListener(this);
    mChildren.add(h);
    HSrel.add(surfaceID);
  }
  
  void addReleasable(int ID, String aCaption){
    ReleasableButton r = new ReleasableButton(ID, aCaption, ""); // should be done for the initial button
    r.addListener(this);
    mChildren.add(r);
  }
  
  int getID(){
    return _ID;
  }
  
  void renderElement(){
    if (active){
      fill(125,125,125);
      rect( (int)_Pos.x - 5, (int)_Pos.y - 5, (int)_Size.x + 10, (int)(_Size.y * (mChildren.size())) + _Size.y + (5 * mChildren.size()) + 10);
      
      fill (50);
      textAlign(CENTER, CENTER);
      text(_Name, (int)_Pos.x, (int)_Pos.y, (int)_Size.x, (int)_Size.y);
      
      for (int i = 0; i < mChildren.size(); ++i){
        UIElement e = (UIElement)mChildren.get(i);
          e.renderElement();
      }
      
      if (activeSurfaceID >= 0){
        int index = Integer.parseInt(HSrel.get(activeSurfaceID).toString());
        if (index >= 0){
          MenuSurface ms = (MenuSurface) surfaceHolder.get(index);
          ms.renderElement();
        }
      }
      
    } else {
      activator.renderElement();
    }
  }
  
  void updateElement(){
    boolean over = false;
    if (active){
      for (int i = 0; i < _CurPos.size(); ++i){
        TuioCursor p = (TuioCursor) _CurPos.get(i);
        
      for (int j = 0; j < mChildren.size(); ++j){
        UIButtonElement e = (UIButtonElement)mChildren.get(j);
        if (e.isOver(p)) {
          e.onCursorOver();
          e.updateElement();
          over = true;
        } else {
          if (!over)
            e.deactivate();
        }
      }
      
      if (activeSurfaceID >= 0){
        println(activeSurfaceID);
        for (int k = 0; k < surfaceHolder.size(); ++k){ // there is a bug here, the surface should not be updated is it's not active
          MenuSurface s = (MenuSurface) surfaceHolder.get(k);
          if (s.isOver(p)){
            s.setCursor(p);
          } else {
            s.removeCursor(p);
          }
          s.updateElement();
        }
      }
      
      if (!isOver(p) && _CurPos.size() == 1){
         active = false;
         activeSurfaceID = -1;
      }
      
      }
    } else {
      
      for (int i = 0; i < _CurPos.size(); ++i){
        TuioCursor p = (TuioCursor) _CurPos.get(i);
        
        if (activator.isOver(p)){
          activator.updateElement();
          break;
        } else {
          activator.deactivate();
          activeSurfaceID = -1;
        }
      }
      
      
    }
  }
  
  boolean isOver(TuioCursor tcur){
    if (active){
      PVector p = new PVector(_Pos.x - 10, _Pos.y - 10);
      PVector s = new PVector((int)_Size.x + 20, (int)(_Size.y* (mChildren.size() + 1)) + (10 * (mChildren.size() +1 )) + 10);
      return Collision.hitQuad(p, s, new PVector(tcur.getScreenX(width), tcur.getScreenY(height)));
    } else {
      return activator.isOver(tcur);
    }  
  }
  
  void setActive(boolean a){
    if (a){
      activator.onCursorOver();
    } else {
      activator.deactivate();
      active = false;
      activeSurfaceID = -1;
    }
  }

  ArrayList getElementRArray(){
   return new ArrayList();
  } 
  
  // callbacks
  
  void onOver(int ID){}
  
  void onRelease(int ID){
    _Listener.onRelease(_ID, ID);
  }
  
  void onClick(int ID){}
  
  void onHold(int ID){
    if (ID == 0){
      active = true;
    } else {
      activeSurfaceID = ID;
      _Listener.onHold(_ID, ID);
    }
  }
  
}



