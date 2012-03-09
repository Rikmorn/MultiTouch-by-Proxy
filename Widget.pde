abstract class Widget extends Window { // just a window that can't be resized
  
  String _Title;
  
  Widget(String aTitle, PVector aPos, PVector aSize, UISceneElement aParent){
    super(aPos, aSize, aParent);
    _Title = aTitle;
    sizableFrame(false);
  }
  
  void setTitle(String aTitle){
    _Title = aTitle;
  }
  
  void onOver(int ID) {}
  
  void onRelease(int ID) {}
  
  void onClick(int ID) {}
  
}
