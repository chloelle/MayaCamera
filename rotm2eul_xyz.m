function [ rotation_angles_radians ] = rotm2eul_xyz( R )
%rotm2eul_xyz Convert rotation matrix to euler angles assume XYZ rotation
%   order.
%   Reference: https://www.learnopencv.com/rotation-matrix-to-euler-angles/

eps = 1e-6;
if (norm(R'*R - eye(3)) < eps) % Is a rotation matrix
    sy = sqrt(R(1, 1)*R(1, 1) + R(2, 1)*R(2, 1));
    singular = (sy < eps);
    if ~singular % Is non singular
        x = atan2(R(3,2), R(3,3));
        y = atan2(-1*R(3,1), sy);
        z = atan2(R(2,1), R(1,1));
    else
        x = atan2(-1*R(2,3), R(2,2));
        y = atan2(-1*R(3,1), sy);
        z = 0;
    end
    rotation_angles_radians = [x, y, z];
else
    rotation_angles_radians = false;
end

end

