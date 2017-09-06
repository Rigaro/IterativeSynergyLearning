%
% Append iteration for 1DOF simulation
%
% Hand realted
pfH(:,i) = simOut.p(end,:);   % Historic end position data
% for j=1:length(simOut.tout)
xPosH(:,i) = simOut.p(:,1);
yPosH(:,i) = simOut.p(:,2);
zPosH(:,i) = simOut.p(:,3);
% end
% Joint related
% for j=1:length(simOut.q_s)
q_aH(:,i) = simOut.q_s(:,1);        % Historic shoulder position data
q_fH(:,i) = simOut.q_s(:,2);
q_rH(:,i) = simOut.q_s(:,3);
% end
% for j=1:length(simOut.q_e)
q_eH(:,i) = simOut.q_e(:,1);        % Historic elbow position data
% end
% Learning realted
JH(i) = cost(p_f,pfH(:,i));            % Historic cost data