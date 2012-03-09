// main class where the interface is designed and all children allocated

class Desktop implements FocusListener, ButtonListener, HoldableListener{
  
  ArrayList bHolders;
  Scene aScene;
  ArrayList boundCursors;
  PImage _back;
  
  // allocate stuff and design interface
  Desktop(){
    bHolders = new ArrayList();
    boundCursors = new ArrayList();
    
    aScene = new Scene();
    aScene.addFocusListener(this);
    
    final int bSize = 50;
    
    Bar b0= new Bar(new PVector(0, bSize + 20), new PVector(bSize, height - bSize - 20));
    
    Bar b1 = new Bar(new PVector(bSize + 20, height - bSize), new PVector(width - bSize - 20, bSize));
    
    Bar menubar = new Bar(new PVector(0, 0), new PVector(width, bSize));
    
    ReleasableButton videoPlayer = new ReleasableButton(0,"", "Images/video.png");
    videoPlayer.addListener(this);
    b0.addChild(videoPlayer);
    
    ReleasableButton q = new ReleasableButton(1,"", "Images/square.png");
    q.addListener(this);
    b0.addChild(q);
    
    ReleasableButton e = new ReleasableButton(2,"", "Images/circle.png");
    e.addListener(this);
    b0.addChild(e);
    
    ReleasableButton w = new ReleasableButton(3,"", "Images/widget.png");
    w.addListener(this);
    b0.addChild(w);
    
    bHolders.add(b0);
    bHolders.add(b1);
    bHolders.add(menubar);
    
  }
  
  public void setBackground(String aBackground){
    _back = loadImage(aBackground);
    _back.resize(width, height);
  }
  
  public void addCursor(TuioCursor tcur){
    for (int i = 0; i<bHolders.size(); ++i){
       UIBarElement e = (UIBarElement) bHolders.get(i);
       if (e.bindCursor(tcur)) return;
     }
    aScene.bindCursor(tcur);
  }
  
  public void updateCursor(TuioCursor tcur){
    for (int i = 0; i<bHolders.size(); ++i){
       UIBarElement e = (UIBarElement) bHolders.get(i);
       e.updateCursor(tcur);
     }
    aScene.updateCursor(tcur);
  }
  
  public void removeCursor(TuioCursor tcur){
    for (int i = 0; i<bHolders.size(); ++i){
       UIBarElement e = (UIBarElement) bHolders.get(i);
       if (e.unbindCursor(tcur)) return;
     }
    aScene.unbindCursor(tcur);
  }
  
  public void drawDesktop(){
    updateDesktop();
    renderDesktop();
  }
  
  private void updateDesktop(){
     for (int i = 0; i<bHolders.size(); ++i){
       UIBarElement e = (UIBarElement) bHolders.get(i);
       e.updateElement();
     }
     aScene.updateElement();
  }
  
  private void renderDesktop(){
    // draw the background
    if (_back == null) {
      background(255);
    } else {
      background(_back);
    }
    
    //draw the scene
    aScene.renderElement();
    
    // draw the holders
    for (int i = 0; i<bHolders.size(); ++i){
       UIBarElement e = (UIBarElement) bHolders.get(i);
       e.renderElement();
     }
  }
  
  // if the shape focus shanges, change the support holder
  void onFocusChange(ArrayList bButtons, ArrayList aMenu){
    UIBarElement e = (UIBarElement) bHolders.get(1);
    e.changeButtons(bButtons);
    UIBarElement menu = (UIBarElement) bHolders.get(2);
    menu.changeMenu(aMenu);
  }
  // from Button Listener
  void onOver(int ID){}
  
  void onRelease(int ID){
    switch (ID){
      case 0:
        Video v = new Video("Videos/video.mov", new PVector(200,100), new PVector(200,200), aScene);
        aScene.addChild(v);
        break;
      case 1:
        Quad q = new Quad(new PVector(300,250), new PVector(200,200), aScene);
        aScene.addChild(q);
        break;
      case 2:
        Ellipse e = new Ellipse(new PVector(200,100), new PVector(200,200), aScene);
        aScene.addChild(e);
        break;
      case 3:
        TimeWidget t = new TimeWidget("Test", new PVector(500, 100), new PVector(200, 85), aScene);
        aScene.addChild(t);
        break;
    }
  }
  
  void onClick(int ID){}
  
  void onHold(int ID){}
  
}
