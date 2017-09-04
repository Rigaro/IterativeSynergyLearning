% Hand realted
pH(:,i) = simOut.p(:,:,end);   % Historic position data
% Joint related
% q_sH(:,i) = simOut.q_s;        % Historic shoulder position data
% q_eH(:,i) = simOut.q_e;        % Historic elbow position data
% Learning realted
% alphaH(i) = str2double(get_param('sim2DOFArmSynergySimulink/Synergy/alpha','Gain'));
% alphaH(i) = alpha;
JH(i) = cost(p_f,pH(:,i));            % Historic cost data