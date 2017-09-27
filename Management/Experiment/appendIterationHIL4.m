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
q_1H(:,i) = simOut.q_s(:,1);        % Historic shoulder position data (sensor frame)
q_2H(:,i) = simOut.q_s(:,2);
q_3H(:,i) = simOut.q_s(:,3);
qDot_aH(:,i) = simOut.qDot_s(:,1,:);        % Historic shoulder velocity data
qDot_fH(:,i) = simOut.qDot_s(:,2,:);
qDot_rH(:,i) = simOut.qDot_s(:,3,:);
% Numerically integrate position
t_s = (simOut.tout(end)/length(qDot_aH(:,i)))*(0:250);
q_aH(:,i) = cumtrapz(t_s,qDot_aH(:,i));
q_fH(:,i) = cumtrapz(t_s,qDot_fH(:,i));
q_rH(:,i) = cumtrapz(t_s,qDot_rH(:,i));
% 
%
q_eH(:,i) = simOut.q_e(:,1);        % Historic elbow position data
% 
% Learning realted
jerk(i) = (1e-5)*costJerk(simOut.tout',simOut.jerk);
dist(i) = 1*costDist(p_f,pfH(:,i));
JH(i) = 1*costDist(p_f,pfH(:,i))+(1e-5)*costJerk(simOut.tout',simOut.jerk);  
% JH(i) = 1*costDist(p_f,pfH(:,i));            % Historic cost data