classdef armFK < matlab.System & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon
    % 2DOF arm forward kinematics simulink system object.
    %
    % Change log:
    % Date        |   Comment                   |     Owner
    %-------------------------------------------------------
    % 19/07/2017  | Imported from old model and |
    %             | updated definitions         |     ricardog
    % dd/mm/yyyy  | xxxxxxxxxxxxxxxx            |     xxxxxxxx
    %
    % NOTE: When renaming the class name armFK, the file name
    % and constructor name must be updated to use the class name.
    %
    % This template includes most, but not all, possible properties, attributes,
    % and methods that you can implement for a System object in Simulink.
    
    properties
        % Public, tunable properties.
    end
    
    properties (Nontunable)
        % Public, non-tunable properties.
    end
    
    properties (Access = private)
        % Pre-computed constants.
        lA = 0;
        lF = 0;
    end
    
    properties (DiscreteState)
    end
    
    methods
        % Constructor
        function obj = armFK(varargin)
            % Support name-value pair arguments when constructing the object.
            setProperties(obj,nargin,varargin{:});
        end
    end
    
    methods (Access = protected)
        %% Common functions
        function setupImpl(obj,q)
            % Implement tasks that need to be performed only once,
            % such as pre-computed constants.
            % Retrieve external constants.
            obj.lA = get(armDynamics,'lA');
            obj.lF = get(armDynamics,'lF');
        end
        
        function xHand = stepImpl(obj,q)
            % Implement algorithm. Calculate y as a function of
            % input u and discrete states.
            % Position of arm end.
            xArm = obj.lA*sin(q(1));
            yArm = -obj.lA*cos(q(1));
            % Position of forearm end (end effector).
            xFArm = xArm + obj.lF*sin(q(1)+q(2));
            yFArm = yArm - obj.lF*cos(q(1)+q(2));
            % 
%             xHand = [xArm;yArm];
            xHand = [xFArm;yFArm];
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
        
        function flag = isInputSizeLockedImpl(obj,index)
            % Set true when the input size is allowed to change while the
            % system is running.
            flag = false;
        end
        
        function sz = getOutputSizeImpl(obj)
            % Implement if input size does not match with output size.
            sz = [2 1];
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
