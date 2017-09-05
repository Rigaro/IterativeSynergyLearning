% Plot alpha values
figure(1);
plot(alphaH);
title('Synergy gain v. iteration');
xlabel('iteration');
ylabel('\alpha');
% Plot cost values
figure(2);
plot(JH);
title('Cost v. iteration');
xlabel('iteration');
ylabel('Cost');
% Plot q_s
figure(3);
plot(simOut.q_s);
title('Sample shoulder trajectory');
xlabel('sample');
ylabel('q_s (rad)');
% Plot q_e
figure(4);
plot(simOut.q_e);
title('Sample elbow trajectory');
xlabel('sample');
ylabel('q_e (rad)');
% Plot pf(i)
figure(5);
plot(pH(1,:),pH(2,:),'x');
hold on
plot(p_f(1),p_f(2),'ro');
hold off
title('Hand end positions');
xlabel('x (m)');
ylabel('y (m)');
% Plot sample p
for j=1:length(simOut.tout)
    xPos(j) = simOut.p(1,1,j);
    yPos(j) = simOut.p(2,1,j);
end
figure(6);
plot(xPos,yPos);
hold on
plot(p_f(1),p_f(2),'ro');
hold off
title('Sample hand trajectory');
xlabel('x (m)');
ylabel('y (m)');