Perceptron brain;

Point[] points = new Point[1000];
int trainingIndex = 0;

void setup()
{
  size(800, 800);

  // Initialize Points
  for (int i = 0; i < points.length; i++)
  {
    points[i] = new Point();
  }
  // Initialize brain
  brain = new Perceptron(3);
}

void draw() {
  background(255);
  stroke(0);
  //line(0, height, width, 0); // Line to visualize point categories
  Point p1 = new Point(-1, f(-1));
  Point p2 = new Point(1, f(1));
  line(p1.pixelX(), p1.pixelY(), p2.pixelX(), p2.pixelY());

  Point p3 = new Point(-1, brain.guessY(-1));
  Point p4 = new Point(1, brain.guessY(1));
  stroke(255,0,0);
  line(p3.pixelX(), p3.pixelY(), p4.pixelX(), p4.pixelY());

    for (Point pt : points) {
    pt.show();

    // Determine if brain decides correctly
    float[] inputs = {pt.x, pt.y, pt.b};
    float guess = brain.guess(inputs);
    if (guess == pt.label) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }

    // Draw smaller ellipse accordingly
    noStroke();
    ellipse(pt.pixelX(), pt.pixelY(), 8, 8);
  }

  // Train the brain
  // Get the current point to train with
  Point tPoint = points[trainingIndex];
  // Get the input values
  float[] inputs = {tPoint.x, tPoint.y, tPoint.b};
  // Train the brain with these values
  brain.train(inputs, tPoint.label);

  trainingIndex++;
  if (trainingIndex == points.length) { 
    trainingIndex = 0 ;
  }
}


// Train with all the points
void mousePressed() {
  for (Point pt : points) {
    float[] inputs = {pt.x, pt.y, pt.b};
    brain.train(inputs, pt.label);
  }
}
