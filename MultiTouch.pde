/*
 * Java 1.4 so no generics, templates, enum, varargs, foreach, and all the stuff 
 * here http://java.sun.com/developer/technicalArticles/releases/j2se15langfeat/
 */

/*
 * Most classes are based on adding children and iterating through them to update, render, etc
 */

TuioHandler tH;
Desktop desktop;
PFont Globalfont;

void setup() {
  size(800, 572, P2D);
  fill(0);
  loop();
  hint(ENABLE_NATIVE_FONTS);
  Globalfont = createFont("LucindaGrande", 20); 
  
  tH = new TuioHandler(15, 760);
  desktop = new Desktop();
  desktop.setBackground("Images/Background.jpg");
}

void draw() {
  noStroke();
  textFont(Globalfont);
  desktop.drawDesktop();
  tH.renderTuioCursors();
}
  
  
