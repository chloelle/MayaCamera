function [ P, K, R, t ] = MayaCamera2OpenCVCamera( f_maya, size_X, size_Y, rotation_angles_degrees, camera_center, camera_aperture_in_mm)
%MayaCamera2OpenCVCamera Converts from Maya Camera parameters as 
% focal length, image width, image height, rotation Euler angles, camera
% position, and camera aperture in mm to OpenCV projection matrix.
% OpenCV projection matrix represented as P, K, R, and t. 
%   Args: Maya camera and Render settings.
%       camera_aperture_in_mm (along X dimension)
%       size_X (Image width from render settings)
%       size_Y (Image height from render settings)
%       f_maya (Focal length in mm from camera settings)
%       rotation_angle_degrees (Maya camera rotation in order XYZ)
%       camera_center (Maya camera position (xyz))
%   Outputs: 
%       P Projection Matrix = K*[R|t] 
%       K (Extrinsic matrix)
%       R (Rotation matrix)
%       t (Camera translation - not camera center)
% usage: [ P, K, R, t ] = MayaCamera2OpenCVCamera( f_maya, size_X, size_Y, rotation_angles_degrees, camera_center, camera_aperture_in_mm)
%
% You can use the projection matrix now to project points onto an image of
% width,height = [size_X,size_Y], and they'll match your Maya renders for
% the same geometry.

% Compute principle point (px, py) at center of the image.
px = size_X / 2.0; 
py = size_Y / 2.0; 

% Compute focal length in pixels.
f = (f_maya/camera_aperture_in_mm)*size_X; 

% Compute extrinsic matrix K.
K = eye(3);
K(1, 1) = f; 
K(2, 2) = f; 
K(1, 3) = px; 
K(2, 3) = py; 

% Invert the euler rotations angles from Maya. 
rotation_angles_degrees = rotation_angles_degrees * -1; 

% Convert euler rotation angles to radians. 
rotation_angles_radians = deg2rad(rotation_angles_degrees);

% Convert euler rotation angles to rotation matrix. 
R = eul2rotm_xyz(rotation_angles_radians);

% Compute translation based on camera center. t = -1*R*c
t = -1*R*camera_center';

% Setup rotation matrix to handle RH vs. LH coordinate systems. 
F = eye(3);
F(2,2) = -1; 
F(3,3) = -1; 

% Adjust for RH vs. LH coordinate systems. 
t = F*t; 
R = F*R; 

Rt = horzcat(R,t); 

P = K*Rt; 

end

