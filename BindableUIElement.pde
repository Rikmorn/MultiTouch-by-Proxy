interface BindableUIElement extends UIElement { // interface for interface elements that can bind cursors to themselves
  boolean bindCursor(TuioCursor aTcur);
  boolean unbindCursor(TuioCursor aTcur);
  void updateCursor(TuioCursor aTcur);
}
