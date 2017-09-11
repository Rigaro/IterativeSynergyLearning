function [ J ] = costJerk( t, jerk)
%cost Summary of this function goes here
%   Detailed explanation goes here
pIt = length(jerk);
for j=1:pIt
    jerkNorm(j) = norm(jerk(j,:))^2;
end
J = trapz(t,jerkNorm);
end

