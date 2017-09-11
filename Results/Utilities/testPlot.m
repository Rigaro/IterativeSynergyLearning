% Plot alpha values
figure(1);
% hold on
plot(thetaH);
title('Synergy gain v. iteration');
xlabel('iteration');
ylabel('\theta');
% hold off
% Plot cost values
figure(2);
% hold on
plot(JH);
title('Cost v. iteration');
xlabel('iteration');
ylabel('J');
% hold off
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
for j=1:length(xPosH)
    xEnd(j) = xPosH(j,end);
    yEnd(j) = yPosH(j,end);
    zEnd(j) = zPosH(j,end);
end
figure(5);
plot3(xEnd,zEnd,yEnd,'x');
hold on
plot3(p_f(1),p_f(3),p_f(2),'ro');
hold off
title('Hand end positions');
xlabel('x (m)');
ylabel('y (m)');
% Plot sample p
% figure(6);
% plot(xPos,yPos);
% hold on
% plot(p_f(1),p_f(2),'ro');
% hold off
% title('Sample hand trajectory');
% xlabel('x (m)');
% ylabel('y (m)');