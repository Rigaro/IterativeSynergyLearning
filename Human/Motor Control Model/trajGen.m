classdef trajGen < matlab.System & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon
    % trajGen Trajectory Generation
    % ---------------------------------------------------------------------
    % Generates a quintic polynomial trajectory from initial conditions
    % q_o, qDot_o, qDDot_o to end condition q_f, qDot_f, qDDot_f within
    % time t. A random position disturbance is added in order to simulate
    % human performance variation.
    % ---------------------------------------------------------------------
    % @param t simulation time.
    % ---------------------------------------------------------------------
    % Change log:
    % Date        |   Comment           |     Owner
    %-------------------------------------------------------
    % 29/08/2017  | Creation            |     ricardog
    % dd/mm/yyyy  | xxxxxxxxxxxxxxxx    |     xxxxxxxx

    % Public, tunable properties
    properties
        q_o = 0;            % Initial position (rad)
        qDot_o = 0;         % Initial velocity (rad/s)
        qDDot_o = 0;        % Initial acceleration (rad/s^2)
        q_f = 0;            % Final position (rad)
        qDot_f = pi/8;      % Final velocity (rad/s)
        qDDot_f = 0;        % Final acceleration (rad/s^2)
        t_o = 0;            % Trajectory start time (seconds)
        t_f = 3;            % Trajectory end time (seconds)
        d_max = 0;       % Maximum position variation (rad)
    end

    % Public, non-tunable properties
    properties(Nontunable)

    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)
        a;     % Polynomial coefficients.
        d;     % Position disturbance to simulate human variation.
    end

    methods
        % Constructor
        function obj = trajGen(varargin)
            % Support name-value pair arguments when constructing object
            setProperties(obj,nargin,varargin{:})
        end
    end

    methods(Access = protected)
        %% Common functions
        function setupImpl(obj)
            % Compute polynomial coefficients
            A = [[1, obj.t_o, obj.t_o^2,  obj.t_o^3,     obj.t_o^4,    obj.t_o^5];
                 [0,       1, 2*obj.t_o, 3*obj.t_o^2,  4*obj.t_o^3,  5*obj.t_o^4];
                 [0,       0,         2,   6*obj.t_o, 12*obj.t_o^2, 20*obj.t_o^3];
                 [1, obj.t_f, obj.t_f^2,  obj.t_f^3,     obj.t_f^4,    obj.t_f^5];
                 [0,       1, 2*obj.t_f, 3*obj.t_f^2,  4*obj.t_f^3,  5*obj.t_f^4];
                 [0,       0,         2,   6*obj.t_f, 12*obj.t_f^2, 20*obj.t_f^3]];
            b = [obj.q_o; obj.qDot_o; obj.qDDot_o; 
                 obj.q_f; obj.qDot_f; obj.qDDot_f];
            obj.a = inv(A)*b;
            % Compute coefficients of position disturbance
            obj.d = obj.d_max*randi([-100 100],1)/100;
        end

        function [qBar, qBarDot, qBarDDot] = stepImpl(obj,t)
            % Generate current desired position, velocity and acceleration.
            if(t<obj.t_o)
                qBar = obj.q_o;
                qBarDot = obj.qDot_o;
                qBarDDot = obj.qDDot_o;
            elseif(t>obj.t_f)
                qBar = obj.q_f+obj.d;
                qBarDot = obj.qDot_f;
                qBarDDot = obj.qDDot_f;
            else
               qBar = obj.a(1)+obj.a(2)*t+obj.a(3)*t^2+obj.a(4)*t^3+...
                      obj.a(5)*t^4+obj.a(6)*t^5+obj.d*(t-obj.t_o)/(obj.t_f-obj.t_o);
               qBarDot = obj.a(2)+2*obj.a(3)*t+3*obj.a(4)*t^2+...
                         4*obj.a(5)*t^3+5*obj.a(6)*t^4;
               qBarDDot = 2*obj.a(3)+6*obj.a(4)*t+12*obj.a(5)*t^2+...
                          20*obj.a(6)*t^3;
            end
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

        function [out_1,out_2,out_3] = getOutputSizeImpl(obj)
            % Return size for each output port
            out_1 = [1 1];
            out_2 = [1 1];
            out_3 = [1 1];

            % Example: inherit size from first input port
            % out = propagatedInputSize(obj,1);
        end

        function [flag_1,flag_2,flag_3] = isOutputFixedSizeImpl(obj)
            % Set true when the output size is fixed
            flag_1 = true;
            flag_2 = true;
            flag_3 = true;
        end        
        
        
        function [dt_1,dt_2,dt_3] = getOutputDataTypeImpl(~)
            % Set output data type.
            dt_1 = 'double';
            dt_2 = 'double';
            dt_3 = 'double';
        end
        
        function [c1,c2,c3] = isOutputComplexImpl(obj)
            c1 = false;
            c2 = false;
            c3 = false;
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
