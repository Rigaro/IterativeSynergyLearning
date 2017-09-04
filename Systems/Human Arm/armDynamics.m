classdef armDynamics < matlab.System & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon
    % 2DOF arm dynamics simulink system object in state space representation.
    % This file contains the dynamics of the arm to be simulated as a
    % Matlab/Simulink sytem object. The arm is modelled with the general
    % equation of motion and represented in state space. The properties of
    % the system and equations of motion are defined here.
    % States are defined as:
    % - x1: q.           % Joint position.
    % - x2: qDot.        % Joint velocity.
    %
    % Change log:
    % Date        |   Comment           |     Owner
    %-------------------------------------------------------
    % 24/01/2017  | Created template    |     ricardog
    % 23/02/2017  | 2DOF arm dynamics   |     ricardog
    % 19/07/2017  | Updated definitions |     ricardog
    % dd/mm/yyyy  | xxxxxxxxxxxxxxxx    |     xxxxxxxx
    %
    % NOTE: When renaming the class name armDynamics, the file name
    % and constructor name must be updated to use the class name.
    %
    % This template includes most, but not all, possible properties, attributes,
    % and methods that you can implement for a System object in Simulink.
    
    properties
        % Public, tunable properties.
        % Plant properties that should be easily modifieable, e.g.
        
        % Arm properties:
        
        kS = 0;                % Shoulder joint spring constant
        kE = 0;                % Elbow joint spring constant
        dS = -1.2;                 % Shoulder joint damping constant
        dE = -1.2;                 % Elbow joint damping constant
        lA = 0.31;                   % Upper arm length (meters)
        lF = 0.34;                   % Forearm length (meters)
        mA = 1.93;                  % Upper arm mass (kg)
        mF = 1.52;                  % Forearm mass (kg)
        q0 = [0;pi/2];      % Joint spring rest position        
        qInit_s = pi/8;
        qInit_e = 7*pi/8;
        qInit = [ pi/8; 7*pi/8 ];      % Joint displacement initialization value
        qDotInit = [0;0];       % Joint velocity initialization value
    end
    
    properties (Constant)
        % Constants.
        
        g = -9.81;          % Gravity constant
    end
    
    properties (Nontunable)
        % Public, non-tunable properties.
        % Plant properties that are restricted in their access.
    end
    
    properties (Access = private)
        % Pre-computed constants.
        
        % Declare pre-computed constants:
        
        IA = 0;                     % Arm inertia tensor
        IF = 0;                     % Forearm inertia tensor
        
        % Declare pre-computed matrices
        
        K = 0;                      % Spring matrix
        D = 0;                      % Damping matrix
        alpha = 0;                  % Matrix parameter
        beta = 0;                   % Matrix parameter
        delta = 0;                  % Matrix parameter
    end
    
    properties (DiscreteState)
        % System object states.
        x
    end
    
    methods
        % Constructor
        function obj = armDynamics(varargin)
            % Support name-value pair arguments when constructing the object.
            setProperties(obj,nargin,varargin{:});
        end
    end
    
    methods (Access = protected)
        %% Common functions
        function setupImpl(obj,x,u)
            % Implement tasks that need to be performed only once,
            % such as pre-computed constants.
            % Compute inertia tensors.
            obj.IA = obj.mA*(obj.lA^2)/3;
            obj.IF = obj.mF*(obj.lF^2)/12;
            % Compute matrices.
            obj.K = [obj.kS 0;
                 0 obj.kE];
            obj.D = [obj.dS 0;
                 0 obj.dE];
            % Compute constant matrix parameters.
            obj.alpha = obj.IA + obj.IF + (obj.mA*(obj.lA/2)^2) + obj.mF*(obj.lA^2+(obj.lF/2)^2);
            obj.beta = obj.mF*obj.lA*(obj.lF/2);
            obj.delta = obj.IF+obj.mF*(obj.lF/2)^2;
        end
        
        function [xDot] = stepImpl(obj,x,u)
            % Implement tasks that are performed at each time step,
            % such as system dynamics (equations of motion).
            
            % States definition:
            obj.x = x;
%             xDot = zeros(4,1);      % Modify depending on number of states
            % x1: q 'Joint displacement (radians)'
            q = [x(1); x(2)];
            % x2: qDot 'Joint velocity (radians/s)'
            qDot = [x(3); x(4)];
            
            % Input definition:
            % u(1): Shoulder joint Control Signal
            % u(2): Elbow joint Control Signal
            
            % Definitions:
            % Define useful abbreviations and calculations that are
            % repeated often.            
            % Compute cos and sin of joints
            S1 = sin(q(1,1));
            C1 = cos(q(1,1));
            S2 = sin(q(2,1));
            C2 = cos(q(2,1));
            S12 = sin(q(1,1)+q(2,1));
            C12 = cos(q(1,1)+q(2,1));
            
            % Intertial matrix
            M = [obj.alpha+2*obj.beta*C2 obj.delta+obj.beta*C2;
                 obj.delta+obj.beta*C2 obj.delta];
            % Coriolis & Centrifugal matrix
            C = [-obj.beta*S2*qDot(2,1) ...
                 -obj.beta*S2*(qDot(1,1)+qDot(2,1));
                 obj.beta*S2*qDot(1,1) 0];
            %
            % External forces.
            springTau = obj.K*(q-obj.q0);
            damperTau = obj.D*qDot;
            gravityTau = [obj.g*(obj.mA*obj.lA/2+obj.mF*obj.lA)*S1+obj.g*obj.mF*(obj.lF/2)*S12;
                          obj.g*obj.mF*(obj.lF/2)*S12];
            % Compute angular acceleration
%             qDotDot = inv(M)*(-C*qDot + gravityTau + springTau + damperTau + u);
            qDotDot = inv(M)*(-C*qDot + springTau + damperTau + u);
            xDot = [qDot; qDotDot];
        end
        
        function resetImpl(obj)
            % Initialize discrete-state properties.
        end
        
        %% Backup/restore functions
        function s = saveObjectImpl(obj)
            % Save private, protected, or state properties in a
            % structure s. This is necessary to support Simulink
            % features, such as SimState.
        end
        
        function loadObjectImpl(obj,s,wasLocked)
            % Read private, protected, or state properties from
            % the structure s and assign it to the object obj.
        end
        
        %% Simulink functions
        function z = getDiscreteStateImpl(obj)
            % Return structure of states with field names as
            % DiscreteState properties.
            z = struct([]);
        end

        function [sz,dt,cp] = getDiscreteStateSpecificationImpl(~,name)
            % State specification definition.
            sz = [4 1];
            dt = 'double';
            cp = false;
        end
        
        function flag = isInputSizeLockedImpl(obj,index)
            % Set true when the input size is allowed to change while the
            % system is running.
            flag = false;
        end
        
        function [flag_1] = isOutputFixedSizeImpl(obj)
            % Set true when the output size is fixed
            flag_1 = true;
        end        
        
        function [sz_1] = getOutputSizeImpl(obj)
            % Set output size.
            % sz_1 = propagatedInputSize(obj,1);
            sz_1 = [4 1];
        end
        
        function [dt_1] = getOutputDataTypeImpl(~)
            % Set output data type.
            dt_1 = 'double';
        end
        
        function [c1] = isOutputComplexImpl(obj)
            c1 = false;
        end
        
        function icon = getIconImpl(obj)
            % Define a string as the icon for the System block in Simulink.
            icon = mfilename('class');
        end
    end
    
    methods(Static, Access = protected)
        %% Simulink customization functions
        function header = getHeaderImpl(obj)
            % Define header for the System block dialog box.
            header = matlab.system.display.Header(mfilename('class'));
        end
        
        function group = getPropertyGroupsImpl(obj)
            % Define section for properties in System block dialog box.
            group = matlab.system.display.Section(mfilename('class'));
        end
    end
end