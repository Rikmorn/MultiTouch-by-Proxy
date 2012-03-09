class TimeWidget extends Widget { // widget application
  
  PFont font;
  
  TimeWidget(String aTitle, PVector aPos, PVector aSize, UISceneElement aParent){
    super(aTitle, aPos, aSize, aParent);
    
    font = createFont("LucindaGrande", 32); 
  }
  
  void renderElement() {
    super.renderElement();
    PVector p = getCurrentPos();
    PVector s = getCurrentSize();
    
    textFont(font);
    
    int d = day();
    int M = month();
    int y = year();
    int S = second();
    int m = minute();
    int h = hour();
    
    String output = String.valueOf(h) + " : " + String.valueOf(m) + " : " + String.valueOf(S) + "\n" + String.valueOf(d) + "/" + String.valueOf(M) + "/" + String.valueOf(y);
    fill (0);
    textAlign(CENTER, CENTER);
    text(output, (int)p.x, (int)p.y, (int)s.x, (int)s.y);
    textFont(Globalfont);
  }
}

