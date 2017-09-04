classdef armDiffK < matlab.System & matlab.system.mixin.Propagates ...
        & matlab.system.mixin.CustomIcon
    % 2DOF arm differential kinematics simulink system object.
    %
    % Change log:
    % Date        |   Comment                   |     Owner
    %-------------------------------------------------------
    % 19/07/2017  | Imported from old model and |
    %             | updated definitions         |     ricardog
    % dd/mm/yyyy  | xxxxxxxxxxxxxxxx            |     xxxxxxxx
    %
    % NOTE: When renaming the class name armDiffK, the file name
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
        function obj = armDiffK(varargin)
            % Support name-value pair arguments when constructing the object.
            setProperties(obj,nargin,varargin{:});
        end
    end
    
    methods (Access = protected)
        %% Common functions
        function setupImpl(obj,q,qDot)
            % Implement tasks that need to be performed only once,
            % such as pre-computed constants.
            % Retrieve external constants.
            obj.lA = get(armDynamics,'lA');
            obj.lF = get(armDynamics,'lF');
        end
        
        function vHand = stepImpl(obj,q,qDot)
            % Implement algorithm. Calculate y as a function of
            % input u and discrete states.
            % Compute constants
            C1 = cos(q(1));
            S1 = sin(q(1));
            C12 = cos(q(1)+q(2));
            S12 = sin(q(1)+q(2));
            % Compute jacobian matrix;
            J = [[-(obj.lA*S1+obj.lF*S12) -obj.lF*S12];[
                obj.lA*C1+obj.lF*C12 obj.lF*C12]];
            vHand = J*qDot;
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
            sz = [2 1];
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
        
        function sz = getOutputSizeImpl(obj)
            % Implement if input size does not match with output size.
            sz = [2 1];
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
