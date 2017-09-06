clear all
% Initialization
i = 1;                    % Iteration number
iMax = 50;
% Hand realted
p_f = [0.5969;-0.0670;-0.2];   % Desired end position

% Learning realted
% Set initial synergy
alpha = [0,-1,0];
alphaH(i,:) = alpha;            % Historic alpha data
deltaH(i) = 0;

% Simulink initialization
cs = getActiveConfigSet('hil4DOFArmSynergyTemplate');
model_cs = cs.copy;
simOut = sim('hil4DOFArmSynergyTemplate', model_cs); % First run

% Run test
runTest