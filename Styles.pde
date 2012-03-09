class Styles { // used to draw a nice rectangle with round corners, couldn't be static...
  Styles(){}
  
  void roundRect(int x, int y, int  w, int h, int r) {
     noStroke();
     rectMode(CORNER);
    
     int  ax, ay, hr;
     ax=x+w-1;
     ay=y+h-1;
     hr = r/2;
    
     rect(x, y, w, h);
     arc(x, y, r, r, radians(180.0), radians(270.0));
     arc(ax, y, r,r, radians(270.0), radians(360.0));
     arc(x, ay, r,r, radians(90.0), radians(180.0));
     arc(ax, ay, r,r, radians(0.0), radians(90.0));
     rect(x, y-hr, w, hr);
     rect(x-hr, y, hr, h);
     rect(x, y+h, w, hr);
     rect(x+w,y,hr, h);
  }
}

