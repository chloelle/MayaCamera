function [ camera_aperture_in_mm, size_X, size_Y, f_maya, rotation_angle_degrees, camera_center] = OpenCVCamera2MayaCamera( K, R, t, camera_aperture_in_mm )
%OpenCVCamera2MayaCamera Converts from OpenCV projection matrix represented
%   as K, R, t to Maya Camera parameters. 
%   Args: 
%       K (Extrinsic matrix)
%       R (Rotation matrix)
%       t (Camera translation - not camera center)
%       Above should reperesent P = K*[R|t] 
%       camera_aperture_in_mm is the size of the film aperture for 
%          arbitrary scaling, along the X dimension. A good number is 36 mm.
%   Outputs: Maya camera and Render settings based on Projection Matrix.
%       camera_aperture_in_mm (same as input arg, along X dimension)
%       size_X (Image width for render settings)
%       size_Y (Image height for render settings)
%       f_maya (Focal length in mm)
%       rotation_angle_degrees (Maya camera rotation in order XYZ)
%       camera_center (Maya camera position (xyz))
% usage: [ camera_aperture_in_mm, size_X, size_Y, f_maya, rotation_angle_degrees, camera_center] = OpenCVCamera2MayaCamera( K, R, t, camera_aperture_in_mm )

% Set principle point (px, py) at center of the image.
size_X = K(1, 3) * 2; % Image width
size_Y = K(2, 3) * 2; % Image height 

% Focal length calculations
f_avg = (K(1,1) + K(2,2))/2.0; 
f_maya = (f_avg*camera_aperture_in_mm)/size_X; 

% Setup rotation matrix to handle RH vs. LH coordinate systems. 
F = eye(3);
F(2,2) = -1; 
F(3,3) = -1;

% Adjust for RH vs. LH coordinate systems. 
t = F*t; % inv(F) = F
R = F*R; 

% Compute camera center. C = -R't
camera_center = -1*R'*t; 

% Invert the euler rotations angles for Maya. 
R = R'; 

% Convert rotation matrix to euler angles assume XYZ rotation order.
eps = 1e-6;
if (norm(R'*R - eye(3)) < eps) 
    rotation_angles_radians = rotm2eul_xyz(R);
end

% Convert euler rotation angle radians to degrees. 
rotation_angle_degrees = rad2deg(rotation_angles_radians);

end

