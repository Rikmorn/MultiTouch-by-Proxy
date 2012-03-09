class Scaler{ // algorithm used to calculate how to scale objects, used to create a quad based on two points, creates a consistant quad independently on how and were the two points are
  
  PVector aUpperLeft, aSize;
  PVector aInitialCenter, aCurrentCenter;
  PVector aInitialUL, aInitialS;
  
  Scaler(PVector A, PVector B){
    calculateQuad(A, B);
    aInitialUL = new PVector (aUpperLeft.x, aUpperLeft.y);
    aInitialS = new PVector (aSize.x, aSize.y);
    aInitialCenter = new PVector(aCurrentCenter.x, aCurrentCenter.y);
  }
  
  void calculateQuad(PVector A, PVector B){
    if ((A.x <= B.x) && (A.y < B.y)){
      aUpperLeft = new PVector (A.x, A.y);
      aSize = new PVector(B.x - A.x, B.y - A.y);
    }
    
    if ((B.x <= A.x) && (B.y < A.y)){
      aUpperLeft = new PVector (B.x, B.y);
      aSize = new PVector(A.x - B.x, A.y - B.y);
    } 
    
    if ((A.x < B.x) && (A.y >= B.y)){
      aUpperLeft = new PVector(A.x, B.y);
      aSize = new PVector(B.x - A.x, A.y - B.y);
    }
    
    if ((B.x < A.x) && (B.y >= A.y)){
      aUpperLeft = new PVector(B.x, A.y);
      aSize = new PVector(A.x - B.x, B.y - A.y);
    }
    
    aCurrentCenter = new PVector(aUpperLeft.x + (aSize.x / 2), aUpperLeft.y + (aSize.y / 2));
  }
  
  void setCurrentPos(PVector A, PVector B){
    calculateQuad(A,B);
  }
  
  PVector getDeltaOrigin(){
    return new PVector(aUpperLeft.x - aInitialUL.x, aUpperLeft.y - aInitialUL.y);
  }
  
  PVector getDeltaSize(){
    return new PVector(aSize.x - aInitialS.x, aSize.y - aInitialS.y);
  }
  
}
  
  
  
