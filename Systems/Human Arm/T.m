function [ mT ] = T( alpha, a, d, theta )
%   T Creates transformation matrix for a given DH parameters.
%   @param aplha MDH 'alpha' parameter.
%   @param a MDH 'a' parameter.
%   @param d MDH 'd' parameter.
%   @param theta MDH 'theta' parameter.

mT = [[cos(theta),            -sin(theta),           0,           a            ];
      [sin(theta)*cos(alpha), cos(theta)*cos(alpha), -sin(alpha), -d*sin(alpha)];
      [sin(theta)*sin(alpha), cos(theta)*sin(alpha), cos(alpha),  d*cos(alpha) ];
      [0,                     0,                     0,           1            ]];

end

