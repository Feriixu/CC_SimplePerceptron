class Perceptron
{
  float[] weights;
  float lr = 0.0001;

  Perceptron(int n)
  {
    weights = new float[n];
    for (int i = 0; i < weights.length; i++) {
      weights[i] = random(-1, 1);
    }
  }

  float guess(float[] inputs)
  {
    float sum = 0; 

    for (int i = 0; i < weights.length; i++) {
      sum += inputs[i] * weights[i];
    }

    return sign(sum);
  }

  float guessY(float x) {
    //float m = weights[0] / weights[1];
    //float b = weights[2];
    //return m * x + b;
    
    float w0 = weights[0];
    float w1 = weights[1];
    float w2 = weights[2];
    
    return -(w2/w1) - (w0/w1) * x;
  }

  // ReLU activation function
  float ReLU(float input) {
    if (input > 0) {
      return input;
    } else {
      return input / 100;
    }
  }

  // Simple sign activation function
  int sign(float input) {
    return (input > 0) ? 1 : -1;
  }

  // Train the brain
  void train(float[] inputs, float target) {
    // Get current guess
    float guess = guess(inputs);
    // Calculate the error
    float error = target - guess;

    // Adjust weights according to error and their value
    // Limit by learning rate
    for (int i = 0; i < weights.length; i++) {
      weights[i] += error * inputs[i] * lr;
    }
  }
}
