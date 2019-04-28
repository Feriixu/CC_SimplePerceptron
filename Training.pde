float f(float x) {
  return -0.5 * x - 0.4;
}

class Point 
{
  float x;
  float y;
  float b = 1;
  float label;

  Point() {
    x = random(-1, 1);
    y = random(-1, 1);

    label = (y > f(x)) ? 1 : -1;
  }

  Point(float x_, float y_) {
    x = x_;
    y = y_;

    label = (y > f(x)) ? 1 : -1;
  }

  float pixelX() {
    return map(x, -1, 1, 0, width);
  }
  float pixelY() {
    return map(y, -1, 1, height, 0);
  }

  void show() {
    stroke(0);
    if (label == 1) {
      fill(255);
    } else {
      fill(0);
    }



    ellipse(pixelX(), pixelY(), 16, 16);
  }
}
