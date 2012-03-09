interface UIButtonElement extends UIElement{
  void onCursorOver();
  void onCursorRelease();
  boolean isActive();
  void deactivate();
}
