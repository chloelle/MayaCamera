# MayaCamera
Convert to/from Maya Camera parameters and OpenCV camera matrix.

Convert to/from Maya Camera parameters and OpenCV camera matrix. This is useful if you have an OpenCV Projection Matrix (well, in the form K,R,t) and you want to generate a Maya Perspective Camera that will render the same as your perspective matrix projection. Or, if you have a Maya camera, and you want to create an OpenCV camera projection matrix to render the same view.

For now, this is in Matlab. Future release will be straight Maya Python for simple integration.
