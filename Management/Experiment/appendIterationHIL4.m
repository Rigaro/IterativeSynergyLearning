%
% Append iteration for 1DOF simulation
%
% Hand realted
pfH(:,i) = simOut.p(end,:);   % Historic end position data
% 
xPosH(:,i) = simOut.p(:,1);
yPosH(:,i) = simOut.p(:,2);
zPosH(:,i) = simOut.p(:,3);
% 
% Joint related
% 
q_aH(:,i) = simOut.q_s(:,1);        % Historic shoulder position data
q_fH(:,i) = simOut.q_s(:,2);
q_rH(:,i) = simOut.q_s(:,3);
% 
%
q_eH(:,i) = simOut.q_e(:,1);        % Historic elbow position data
% 
% Learning realted
jerk(i) = (1e-5)*costJerk(simOut.tout',simOut.jerk);
dist(i) = 1*costDist(p_f,pfH(:,i));
JH(i) = 1*costDist(p_f,pfH(:,i))+(1e-5)*costJerk(simOut.tout',simOut.jerk);  
% JH(i) = 1*costDist(p_f,pfH(:,i));            % Historic cost data