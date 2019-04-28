import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class CC_SimplePerceptron extends PApplet {

Perceptron brain;

Point[] points = new Point[100];
int trainingIndex = 0;

public void setup()
{
  
  for (int i = 0; i < points.length; i++)
  {
    points[i] = new Point();
  }
  brain = new Perceptron();  
}

public void draw() {
  background(255);
  stroke(0);
  line(0, 0, width, height);
  for (Point pt : points) {
    pt.show();

    float[] inputs = {pt.x, pt.y};
    float guess = brain.guess(inputs);
    if (abs(guess - pt.label) < 0.01f) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    noStroke();
    ellipse(pt.x, pt.y, 16, 16);
  }

  Point trainingPoint = points[trainingIndex];
  float[] inputs = {trainingPoint.x, trainingPoint.y};
  brain.train(inputs, trainingPoint.label);
  trainingIndex++;
  if (trainingIndex == points.length) { 
    trainingIndex = 0 ;
  }
}

public void mousePressed() {
  for (Point pt : points) {
    float[] inputs = {pt.x, pt.y};
    brain.train(inputs, pt.label);
  }
}
class Perceptron
{
  float[] weights = new float[2];
  float lr = 0.1f;

  Perceptron()
  {
    for (int i = 0; i < weights.length; i++)
    {
      weights[i] = random(-1, 1);
    }
  }

  public float guess(float[] inputs)
  {
    float sum = 0; 

    for (int i = 0; i < weights.length; i++)
    {
      sum += inputs[i] * weights[i];
    }

    return sign(sum);
  }

  public float ReLU(float input)
  {
    if (input > 0)
    {
      return input;
    } else
    {
      return input / 100;
    }
  }

  public int sign(float input)
  {
    if (input > 0) { 
      return 1;
    } else {
      return -1;
    }
  }

  public void train(float[] inputs, float target) {
    float guess = guess(inputs);
    float error = target - guess;

    for (int i = 0; i < weights.length; i++) {
      weights[i] += error * inputs[i] * lr;
    }
  }
}
class Point 
{
  float x;
  float y;
  float label;

  Point() 
  {
    x = random(width);
    y = random(height);

    label = x - y;
  }

  public void show()
  {
    stroke(0);
    if (label == 1)
    {
      fill(255);
    } else
    {
      fill(0);
    }
    ellipse(x, y, 32, 32);
  }
}
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CC_SimplePerceptron" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
