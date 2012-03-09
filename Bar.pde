/*
 Create and handle Bar interface elements 
 */

class Bar implements UIBarElement {
  
  ArrayList aButtons;
  ArrayList aCursors;
  PVector _Pos, _Size; 
  ArrayList aMenu;
  
  Styles st;
  
  Bar(PVector aPos, PVector aSize){
    aButtons = new ArrayList();
    aCursors = new ArrayList();
    aMenu = new ArrayList();
    _Pos = aPos;
    _Size = aSize;
    
    st = new Styles();
  }
  
  // organize child buttons (menu buttons too) to make them nice
  
  void organizeItems(){
    for (int i = 0; i < aButtons.size(); ++i){
      UIElement e = (UIElement)aButtons.get(i);
      e.setElementPos(new PVector ((_Pos.x + _Size.x - 120) - ((115 * i) - 5) , _Pos.y));
      e.setElementSize(new PVector (110, _Size.y - 5));
    }
    
    for (int i = 0; i < aMenu.size(); ++i){
      Menu e = (Menu) aMenu.get(i);
      e.setMenuButtonPos(new PVector (_Pos.x + ((100 * i) + 5), _Pos.y + 5));
      e.setMenuButtonSize(new PVector (95, _Size.y - 5));
      e.updateCoords();
    }
  }
  
  boolean isOver(TuioCursor tcur){
    return Collision.hitQuad(_Pos, _Size, new PVector(tcur.getScreenX(width), tcur.getScreenY(height)));
  }
  
  void updateElement(){
    for (int i = 0; i<aCursors.size(); ++i){
      Cursor cur = (Cursor) aCursors.get(i);
      for (int j = 0; j < aButtons.size(); ++j){
      UIButtonElement e = (UIButtonElement)aButtons.get(j);
      if (e.isOver(cur.getCursor())) {
          //e.onCursorOver();
          e.updateElement();
        } else {
          e.deactivate();
        }
      }

      for (int j = 0; j<aMenu.size(); ++j){
        Menu m = (Menu) aMenu.get(j);
        m.setCursorPos(cur.getCursor());
        m.updateElement();
      }

      
    }
  } 
  
  ArrayList getElementRArray() {
    return new ArrayList();
  }
  
  ArrayList getMenuStructure() {
    return null;
  }

  boolean bindCursor(TuioCursor aTcur){
    
    for (int i = 0; i<aMenu.size(); ++i){
      Menu m = (Menu) aMenu.get(i);
      if (m.isActive()){
        m.setCursorPos(aTcur);
      }
    }
    
    if(!Collision.hitQuad(_Pos, _Size, new PVector(aTcur.getScreenX(width), aTcur.getScreenY(height)))){
      return false;
    } else {
      aCursors.add(new Cursor(aTcur));
    }
    
    for (int i = 0; i < aButtons.size(); ++i){
      UIButtonElement e = (UIButtonElement)aButtons.get(i);
      if (e.isOver(aTcur)) {
        e.onCursorOver();
        return true;
      }
    }
    
    for (int i = 0; i<aMenu.size(); ++i){
      Menu m = (Menu) aMenu.get(i);
      if (m.isOver(aTcur)){
        m.setActive(true);
      }
    }

    return true;
  }
  
  boolean unbindCursor(TuioCursor aTcur){
    
    for (int j = 0; j<aMenu.size(); ++j){
      Menu m = (Menu) aMenu.get(j);
      m.removeCursorPos(aTcur);
    }
    
    for (int i = 0; i<aCursors.size(); ++i){
      Cursor cur = (Cursor) aCursors.get(i);
      if (cur.checkID(aTcur)){
        for (int j = 0; j < aButtons.size(); ++j){
          UIButtonElement e = (UIButtonElement)aButtons.get(j);
          if (e.isActive()) {
            e.onCursorRelease();
            e.deactivate();
          }
        }

        aCursors.remove(i);
        return true;
      }
    }
    return false;
  }
  
  void updateCursor(TuioCursor aTcur){ //update menu
    for (int i = 0; i<aCursors.size(); ++i){
      Cursor cur = (Cursor) aCursors.get(i);
      if (cur.checkID(aTcur)){
        for (int j = 0; j < aButtons.size(); ++j){
          UIButtonElement e = (UIButtonElement)aButtons.get(j);
          //e.updateCursor(aTcur); needs to know where the cursor is
          if (e.isOver(aTcur)) {
            e.onCursorOver();
          } else {
            e.deactivate();
          }
          
        }
      }
    }
  }
  
  void addChild(UIElement aChild){
    aChild.setElementPos(new PVector (_Pos.x + 5, (_Pos.y + _Size.y - 55) - ((50 * aButtons.size()) - 5)) );
    aChild.setElementSize(new PVector (_Size.x - 5, 45));
    aButtons.add(aChild);
  }

  void renderElement(){
    fill(150, 150, 150, 150);
    st.roundRect((int)_Pos.x, (int)_Pos.y, (int)_Size.x, (int)_Size.y, 15);
    
    for (int i = 0; i < aButtons.size(); ++i){
      UIButtonElement e = (UIButtonElement)aButtons.get(i);
      e.renderElement();
    }
    
    for (int i = 0; i<aMenu.size(); ++i){
      Menu m = (Menu) aMenu.get(i);
      m.renderElement();
    }
    
  }
  
  void changeButtons(ArrayList buttons){ // by using this we loose all privious children
    aButtons = buttons;
    organizeItems();
  }

  void changeMenu(ArrayList menu){
    aMenu = menu;
    organizeItems();
  }
  
  void setElementPos(PVector nPos){
    _Pos = nPos;
  }
  
  void setElementSize(PVector nSize){
    _Size = nSize;
  }

}


