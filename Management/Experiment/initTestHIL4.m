% clear all
% Initialization
i = 1;                    % Iteration number
iMax = 50;
% Hand realted
p_f = [0.5969;-0.0670;-0.2];   % Desired end position

% Learning realted
% Set initial synergy
gamma = 30;
theta = [0,0,0];
thetaH(i,:) = theta;            % Historic alpha data
h = 0;
JhpfH(i) = 0;
aDither = [0.1,0.1,0.1];
wDither = [0.8*pi,pi,0.6*pi];
% sgn = [1,1,1];

% Simulink initialization
cs = getActiveConfigSet('hil4DOFArmSynergyTemplate');
model_cs = cs.copy;
simOut = sim('hil4DOFArmSynergyTemplate', model_cs); % First run

% Run test
runTest