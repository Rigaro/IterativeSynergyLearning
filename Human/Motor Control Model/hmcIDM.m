classdef hmcIDM < matlab.System & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon
    % hmcIDM Human Motor Control inverse dynamic model
    % ---------------------------------------------------------------------
    % Generates the feedforward torques according to the inverse dynamic
    % model of the human arm.
    % ---------------------------------------------------------------------
    % @param qBar Desired joint position (rad).
    % @param qBarDot Desired joint velocity (rad/s).
    % @param qBarDDot Desired joint acceleration (rad/s^2).
    % ---------------------------------------------------------------------
    % Change log:
    % Date        |   Comment           |     Owner
    %-------------------------------------------------------
    % 29/08/2017  | Creation            |     ricardog
    % dd/mm/yyyy  | xxxxxxxxxxxxxxxx    |     xxxxxxxx

    % Public, tunable properties
    properties
        % Arm properties:
        
        kS = 0;                % Shoulder joint spring constant
        kE = 0;                % Elbow joint spring constant
        dS = -1.0;                 % Shoulder joint damping constant
        dE = -1.0;                 % Elbow joint damping constant
        lA = 0.29;                   % Upper arm length (meters)
        lF = 0.32;                   % Forearm length (meters)
        mA = 1.93;                  % Upper arm mass (kg)
        mF = 1.52;                  % Forearm mass (kg)
        q0 = 0;      % Joint spring rest position
    end

    % Public, non-tunable properties
    properties(Nontunable)

    end

    % Constants
    properties (Constant)
        g = -9.81;          % Gravity constant
    end
    
    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)
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

    methods
        % Constructor
        function obj = hmcIDM(varargin)
            % Support name-value pair arguments when constructing object
            setProperties(obj,nargin,varargin{:})
        end
    end

    methods(Access = protected)
        %% Common functions
        function setupImpl(obj,qBar,qBarDot,qBarDDot)
            % Compute inertia tensors.
            obj.IA = obj.mA*(obj.lA^2)/3;
            obj.IF = obj.mF*(obj.lF^2)/12;
            % Compute matrices.
            obj.K = -obj.kS;
            obj.D = -obj.dS;
            % Compute constant matrix parameters.
            obj.alpha = obj.IA + (obj.mA*(obj.lA/2)^2);
        end

        % Compute feedforward torque.
        function tau = stepImpl(obj,qBar,qBarDot,qBarDDot)
            % Definitions:
            % Define useful abbreviations and calculations that are
            % repeated often.            
            % Compute cos and sin of joints
            S1 = sin(qBar);
            C1 = cos(qBar);
            
            % Intertial matrix
            M = obj.alpha;
            % Coriolis & Centrifugal matrix
            C = 0;
            %
            % External forces.
            springTau = obj.K*(qBar-obj.q0);
            damperTau = obj.D*qBarDot;
            gravityTau = -obj.g*(obj.mA*obj.lA/2)*S1;
            % Compute torque
%             tau = M*qBarDDot + C*qBarDot  + gravityTau + springTau + damperTau; %w/ gravity
            tau = M*qBarDDot + C*qBarDot + springTau + damperTau;
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end

        %% Backup/restore functions
        function s = saveObjectImpl(obj)
            % Set properties in structure s to values in object obj

            % Set public properties and states
            s = saveObjectImpl@matlab.System(obj);

            % Set private and protected properties
            %s.myproperty = obj.myproperty;
        end

        function loadObjectImpl(obj,s,wasLocked)
            % Set properties in object obj to values in structure s

            % Set private and protected properties
            % obj.myproperty = s.myproperty; 

            % Set public properties and states
            loadObjectImpl@matlab.System(obj,s,wasLocked);
        end

        %% Simulink functions
        function ds = getDiscreteStateImpl(obj)
            % Return structure of properties with DiscreteState attribute
            ds = struct([]);
        end

        function flag = isInputSizeLockedImpl(obj,index)
            % Return true if input size is not allowed to change while
            % system is running
            flag = true;
        end

        function out = getOutputSizeImpl(obj)
            % Return size for each output port
            out = [1 1];

            % Example: inherit size from first input port
            % out = propagatedInputSize(obj,1);
        end

        function [flag_1] = isOutputFixedSizeImpl(obj)
            % Set true when the output size is fixed
            flag_1 = true;
        end        
                
        function [dt_1] = getOutputDataTypeImpl(~)
            % Set output data type.
            dt_1 = 'double';
        end
        
        function [c1] = isOutputComplexImpl(obj)
            c1 = false;
        end
        
        function icon = getIconImpl(obj)
            % Define icon for System block
            icon = mfilename('class'); % Use class name
            % icon = 'My System'; % Example: text icon
            % icon = {'My','System'}; % Example: multi-line text icon
            % icon = matlab.system.display.Icon('myicon.jpg'); % Example: image file icon
        end
    end

    methods(Static, Access = protected)
        %% Simulink customization functions
        function header = getHeaderImpl
            % Define header panel for System block dialog
            header = matlab.system.display.Header(mfilename('class'));
        end

        function group = getPropertyGroupsImpl
            % Define property section(s) for System block dialog
            group = matlab.system.display.Section(mfilename('class'));
        end
    end
end
