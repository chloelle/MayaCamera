function [ R ] = eul2rotm_xyz( rotation_angles_radians )
%eul2rotm_xyz Convert Euler angles to Rotation matrix
%   Assumes rotation order is X,Y,Z.
%   Reference: https://www.learnopencv.com/rotation-matrix-to-euler-angles/

R_x = eye(3);
R_x(2,2) = cos(rotation_angles_radians(1));
R_x(2,3) = -1*sin(rotation_angles_radians(1));
R_x(3,2) = sin(rotation_angles_radians(1));
R_x(3,3) = cos(rotation_angles_radians(1));

R_y = eye(3);
R_y(1,1) = cos(rotation_angles_radians(2));
R_y(1,3) = sin(rotation_angles_radians(2));
R_y(3,1) = -1*sin(rotation_angles_radians(2));
R_y(3,3) = cos(rotation_angles_radians(2));

R_z = eye(3);
R_z(1,1) = cos(rotation_angles_radians(3));
R_z(1,2) = -1*sin(rotation_angles_radians(3));
R_z(2,1) = sin(rotation_angles_radians(3));
R_z(2,2) = cos(rotation_angles_radians(3));

R = R_x*R_y*R_z;
end

