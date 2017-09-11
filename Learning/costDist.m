function [ J ] = costDist( p_f, p )
%cost Summary of this function goes here
%   Detailed explanation goes here

J = norm(p-p_f)^2;
end

