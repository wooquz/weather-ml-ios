# ML Model for Weather Prediction

## MLModel.mlmodel

This directory should contain a trained CoreML model file named `MLModel.mlmodel`.

### Creating the ML Model

1. Open Xcode and create a new Create ML project
2. Train a regression model using weather data (temperature, humidity, pressure, wind speed)
3. Export the model as `MLModel.mlmodel`
4. Add the model file to this Models directory

### Model Input Features
- Temperature (Double)
- Humidity (Int)
- Pressure (Int)
- Wind Speed (Double)

### Model Output
- Predicted Temperature (Double)

### Usage

The `MLPredictionService.swift` in Services folder will load and use this model for weather predictions.

**Note:** The actual .mlmodel file needs to be created separately in Xcode using Create ML or similar tools.
