import TUIO.*;
    
TuioProcessing initTuio(){ 
  return new TuioProcessing(this);
}

// these callback methods are called whenever a TUIO event occurs
// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
 // println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  //println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  //println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
       // +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  //println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  //println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getScreenX(width)+" "+tcur.getScreenY(height));
  //uiM.testHit(tcur.getScreenX(width), tcur.getScreenY(height), tcur.getCursorID());
  //uiM.addCursor(tcur);
  tH.addTuioCursor(tcur);
}

// called when a cursor is moved
void updateTuioCursor(TuioCursor tcur) {
 // println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
       // +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
  //uiM.updateUI();
  tH.updateTuioCursor(tcur);
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
 // println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
 //uiM.removeCursor(tcur);
  //uiM.releaseCursor(tcur.getCursorID());
  tH.removeTuioCursor(tcur);
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { 
  redraw();
}

class TuioHandler{
  // these are some helper variables which are used
  // to create scalable graphical feedback
  float cursor_size;
  float table_size;
  float scale_factor;
  PFont font;
  
  TuioProcessing tuioClient;
  
  TuioHandler(int aC, int aT){
    cursor_size = aC;
    table_size = aT;
    
    font = createFont("Arial", 18);
    scale_factor = height/table_size;
    
    tuioClient = initTuio(); 
  }
  
  void renderTuioCursors(){
    textFont(font, 18*scale_factor);
    float cur_size = cursor_size*scale_factor; 
  
    Vector tuioCursorList = tuioClient.getTuioCursors();
    for (int i=0;i<tuioCursorList.size();i++) {
      TuioCursor tcur = (TuioCursor)tuioCursorList.elementAt(i);
  
      stroke(192,192,192);
      fill(192,192,192);
      ellipse( tcur.getScreenX(width), tcur.getScreenY(height),cur_size,cur_size);
      
      fill(0);
      text(""+ tcur.getCursorID(),  tcur.getScreenX(width)-5,  tcur.getScreenY(height)+5);
    }
  }
  
  // called when a cursor is added to the scene
  void addTuioCursor(TuioCursor tcur) {
    desktop.addCursor(tcur);
  }
  
  // called when a cursor is moved
  void updateTuioCursor (TuioCursor tcur) {
    desktop.updateCursor(tcur);
  }
  
  // called when a cursor is removed from the scene
  void removeTuioCursor(TuioCursor tcur) {
   desktop.removeCursor(tcur);
  }
  
}


