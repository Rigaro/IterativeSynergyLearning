i = 1;

qDot_aH(:,i) = simOut.qDot_s(:,1,:);        % Historic shoulder velocity data
qDot_fH(:,i) = simOut.qDot_s(:,2,:);
qDot_rH(:,i) = simOut.qDot_s(:,3,:);
% Numerically integrate position
t_s = (simOut.tout(end)/length(qDot_aH(:,i)))*(0:250);
q_aH(:,i) = cumtrapz(t_s,qDot_aH(:,i));
q_fH(:,i) = cumtrapz(t_s,qDot_fH(:,i));
q_rH(:,i) = cumtrapz(t_s,qDot_rH(:,i));
t_s = (simOut.tout(end)/length(qDot_aH(:,1)))*(0:250);
q_aT(:,1) = cumtrapz(t_s,qDot_aH(:,1));
q_fT(:,1) = cumtrapz(t_s,qDot_fH(:,1));
q_rT(:,1) = cumtrapz(t_s,qDot_rH(:,1));

figure(3);
hold on
plot(t_s,q_aT(:,1));
plot(t_s,q_fT(:,1));
plot(t_s,q_rT(:,1));
title('Sample shoulder trajectory');
xlabel('Time (sec)');
ylabel('q_s (rad)');
hold off