% Plot alpha values
figure(1);
hold on
plot(thetaH);
title('Synergy parameter v. iteration');
xlabel('Iteration');
ylabel('\theta');
hold off
% Plot cost values
figure(2);
hold on
plot(JH);
title('Cost v. iteration');
xlabel('Iteration');
ylabel('J');
hold off
% Plot q_s
figure(3);
hold on
t_s = 0.02*(0:250);
plot(t_s,q_aH(:,55));
plot(t_s,q_fH(:,55));
plot(t_s,q_rH(:,55));
title('Sample shoulder trajectory');
xlabel('Time (sec)');
ylabel('q_s (rad)');
hold off
% Plot q_e
figure(4);
hold on
t_e = 0.005*(0:1000);
plot(t_e,q_eH(:,55));
title('Sample elbow trajectory');
xlabel('Time (sec)');
ylabel('q_e (rad)');
hold off
% Plot pf(i)
for j=1:length(xPosH)
    xEnd(j) = xPosH(j,end);
    yEnd(j) = yPosH(j,end);
    zEnd(j) = zPosH(j,end);
end
figure(5);
hold on
plot3(xEnd,zEnd,yEnd,'x');
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
% ylabel('y (m)');% Plot cost values
figure(6);
hold on
plot(dist);
title('Cost v. iteration');
xlabel('Iteration');
ylabel('J');
% hold on;
plot(jerk);
hold off