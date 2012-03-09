// static colision class to check for colitions between a point and a quad and ellipse
static class Collision{
  static boolean hitQuad(PVector QPos, PVector QSize, PVector QPoint){
    return (QPoint.x>=QPos.x && QPoint.x<=QPos.x+QSize.x && QPoint.y>=QPos.y && QPoint.y<=QPos.y+QSize.y) ? true : false;
  }
  
  static boolean hitEllipse(PVector QPos, PVector QSize, PVector QPoint){
    float nx = (QPoint.x - QPos.x)  / (QSize.x / 2);
    float ny = (QPoint.y - QPos.y)  / (QSize.y / 2);
    return ((sq(nx) + sq(ny)) <= 1)? true : false;
  }
  
}
