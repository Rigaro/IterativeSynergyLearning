if(i<2)
    v(i) = 0;
    i = i + 1;
else
    %%%%%% Gradient estimation %%%%%%
    % High pass filter
    v(i) = -(h*v(i-1))+(JH(i)-JH(i-1));
    
    % Estimation dither
    for j=1:3        
        gradJ(j) = aDither(j)*cos(wDither(j)*i)*v(i);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%% Gradient descent %%%%%%%%%
    % Gradient
    theta = thetaH(i,:) + gamma*gradJ;
    % Gradient dither
    for j=1:3
        theta(j) = theta(j) + aDither(j)*cos(wDither(j)*i);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    i = i + 1;
end
% i
theta
thetaH(i,:) = theta;