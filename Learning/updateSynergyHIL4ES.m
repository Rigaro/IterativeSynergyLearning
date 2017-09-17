if(i<2)
    JhpfH(i) = 0;
    i = i + 1;
else
    %%%%%% Gradient estimation %%%%%%
    % High pass filter
    JhpfH(i) = -(h*JhpfH(i-1))+(JH(i)-JH(i-1));
%     JhpfH(i) = JH(i);
    % Estimation dither
    for j=1:3        
        grad(j) = aDither(j)*cos(wDither(j)*i)*JhpfH(i);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%% Gradient descent %%%%%%%%%
    % Gradient
    theta = thetaH(i,:) + gamma*grad;
    % Gradient dither
    for j=1:3
        theta = theta + aDither(j)*cos(wDither(j)*i);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    i = i + 1;
end
% i
theta
thetaH(i,:) = theta;