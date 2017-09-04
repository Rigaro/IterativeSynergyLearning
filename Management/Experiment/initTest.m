clear all
% Initialization
i = 1;                    % Iteration number

% Hand realted
% pH(:,1) = p(:,:,end);   % Historic position data
p_f = [0.5969;-0.0670];   % Desired end position

% Joint related
% q_sH(:,i) = q_s;        % Historic shoulder position data
% q_eH(:,i) = q_e;        % Historic elbow position data

% Learning realted
% Set initial synergy
alpha = 0;
alphaH(i) = 0;            % Historic alpha data
% set_param('sim2DOFArmSynergySimulink/Synergy/alpha','Gain',num2str(alphaH(i)));
% JH(i) = 10000;            % Historic cost data

% Simulink initialization
% cs = getActiveConfigSet('sim2DOFArmSynergyTemplate');
% model_cs = cs.copy;
% simOut = sim('sim2DOFArmSynergyTemplate', model_cs); % First run
cs = getActiveConfigSet('hil2DOFArmSynergyTemplate');
model_cs = cs.copy;
simOut = sim('hil2DOFArmSynergyTemplate', model_cs); % First run

% Run test
runTest