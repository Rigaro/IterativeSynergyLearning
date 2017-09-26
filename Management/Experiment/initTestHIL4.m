% clear all
% Initialization
i = 50;                    % Iteration number
iMax = 75;
% Hand realted
p_f = [0.5969;-0.0670;-0.2];   % Desired end position: length, height, centering

% Learning realted
% Set initial synergy
gamma = 30;
h = 0;
aDither = [0.1,0.1,0.1];
wDither = [0.8*pi,pi,0.6*pi];
%
% theta = [0,0,0];
% thetaH(i,:) = theta;            % Historic alpha data
% JhpfH(i) = 0;

% Simulink initialization
cs = getActiveConfigSet('hil4DOFArmSynergyTemplate');
% cs = getActiveConfigSet('hil4DOFArmShared');
model_cs = cs.copy;
simOut = sim('hil4DOFArmSynergyTemplate', model_cs); % First run
% simOut = sim('hil4DOFArmShared', model_cs); % First run

% Run test
runTest