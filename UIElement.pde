interface UIElement {
  void addChild(UIElement aChild);
  void renderElement();
  void updateElement();
  boolean isOver(TuioCursor tcur); // check it cursor is over them
  void setElementPos(PVector nPos);
  void setElementSize(PVector nSize);
  ArrayList getElementRArray(); // button list for the botton bar, maybe move it somewhere else
  ArrayList getMenuStructure(); // button list for the botton bar, maybe move it somewhere else
}

