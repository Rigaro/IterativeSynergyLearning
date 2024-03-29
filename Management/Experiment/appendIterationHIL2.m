%
% Append iteration for 1DOF simulation
%
% Hand realted
pfH(:,i) = simOut.p(:,:,end);   % Historic end position data
for j=1:length(simOut.tout)
    xPosH(j,i) = simOut.p(1,1,j);
    yPosH(j,i) = simOut.p(2,1,j);
end
% Joint related
for j=1:length(simOut.q_s)
    q_sH(j,i) = simOut.q_s(j);        % Historic shoulder position data
end
for j=1:length(simOut.q_e)
    q_eH(j,i) = simOut.q_e(j);        % Historic elbow position data
end
% Learning realted
% alphaH(i) = str2double(get_param('sim2DOFArmSynergySimulink/Synergy/alpha','Gain'));
% alphaH(i) = alpha;
JH(i) = cost(p_f,pfH(:,i));            % Historic cost data