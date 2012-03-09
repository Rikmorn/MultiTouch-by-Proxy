/*
 * used to hold cursor information, valuable for bindable uielements.
 * provides distance calculations, lifetime and other misc information about a specific cursor
 */
 
class Cursor{
  TuioCursor tcur;
  int initialX;
  int initialY;
  float time;
  
  Cursor(TuioCursor aTcur){
    tcur = aTcur;
    initialX = tcur.getScreenX(width);
    initialY = tcur.getScreenY(height);
    time = millis();
  }
  // returns distance between the current position of the cursor and it's initial position
  PVector getDDistance(){
    return new PVector(tcur.getScreenX(width) - initialX, tcur.getScreenY(height) - initialY);
  }
  
  // returns cursor's initial position
  PVector getInitialPos(){
    return new PVector(initialX, initialY);
  }
  
  // returns cursor's current position
  PVector getCurrentPosition(){
    return new PVector(tcur.getScreenX(width), tcur.getScreenY(height));
  }
  
  // sets cursor's initial position, good for some cases
  void setInitialPos(PVector aInit){
    initialX = (int) aInit.x;
    initialY = (int) aInit.y;
  }
  
  // returns cursor's ID 
  boolean checkID(TuioCursor aTcur){
    return (tcur.getCursorID() == aTcur.getCursorID())?true:false;
  }
  
  // returns cursor's how long the cursor has been held on the track pad
  float getLifeTime(){
    return millis() - time;
  }
  
  // returns cursor instance
  TuioCursor getCursor(){
    return tcur;
  }
  
}
