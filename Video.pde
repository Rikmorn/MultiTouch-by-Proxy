import processing.video.*;

Movie initVideo(String dir) {
  return new Movie(this, dir);
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

// video application
class Video extends Window implements MenuListener, UIMenuSurfaceListener {
  Movie aMovie;
  
  float aMovieDur;
  float aMovieTime;
  
  boolean playing;
  
  Video(String aM, PVector aPos, PVector aSize, UISceneElement aParent){
    super(aPos, aSize, aParent);
    
    // add buttons to the bottom bar
    addControlButton(new ReleasableButton(0, "Play/Pause", ""));
    addControlButton(new ReleasableButton(1, "Exit", ""));
    
    // add menus
    MenuSurface ms = new MenuSurface("Hello", 0);
    ms.addButtonChild(new ReleasableButton(0, "Play/Pause", ""));
    ms.addButtonChild(new ReleasableButton(1, "Exit", ""));
    ms.setListener(this);
    
    Menu m = new Menu("Options", 0);
    m.addMenuSurface(ms);
    m.addListener(this);
    m.addHoldable(0, "Video");
    m.addReleasable(0, "Exit");
    
    addMenu(m);
    
    aMovie = initVideo(aM);
    aMovieTime = aMovie.time();
    
    aMovie.loop();
    playing = true;
  }
  
  /* from Window, behavious of assigned relesable buttons */
  
  void onOver(int ID){}
  
  void onRelease(int ID){
    if (ID == 1) {
      _Parent.killChild(this);
      return;
    }
    if (playing){
      aMovie.pause();
      playing = false;
    } else {
      aMovie.play();
      playing = true;
    }
  }
  
  void onClick(int ID) {}
  
  void renderElement() {
    super.renderElement();
    PVector p = getCurrentPos();
    PVector s = getCurrentSize();
    image(aMovie, (int)p.x, (int)p.y, (int)s.x, (int)s.y);
  }
  
  // from MenuListener
  void onRelease(int menuId, int commandID){
    if (menuId == 0 && commandID == 0){
        _Parent.killChild(this);
    }
  }
  
  void onHold(int menuId, int commandID){
  }
  
  // from surface listener
  void onChoice(int surfaceID, int elementID){
    if (surfaceID == 0 && elementID == 0){
      if (playing){
        aMovie.pause();
        playing = false;
      } else {
        aMovie.play();
        playing = true;
      }
    } else if (surfaceID == 0 && elementID == 1){
      _Parent.killChild(this);
    }
  }
  
}
