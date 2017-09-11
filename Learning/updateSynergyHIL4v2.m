if(i<3)
    alpha = alphaH(i,:) - 0.1;
    i = i + 1;
else
%     Jav = (JH(i)+JH(i-1)+JH(i-2))/3; 
    dJ = JH(i)-JH(i-1);
    dalpha = alphaH(i,:)-alphaH(i-1,:);
    grad = dJ./dalpha;
%     dq_s(1) = 0.5*(q_aH(end,i)-q_aH(1,i));
%     dq_s(2) = 0.5*(q_fH(end,i)-q_fH(1,i));
%     dq_s(3) = 0.5*(q_rH(end,i)-q_rH(1,i));
%     for j=1:3
%         if(grad(j)>0.5)
%             grad(j) = 0.5;
%         elseif(grad(j)<-0.5)
%             grad(j) = -0.5;
%         end
%     end
    gamma = 0.9*gamma;
    if(gamma<0.005)
        gamma = 0.005;
    end
%     alpha = alphaH(i,:) - gamma*grad.*dq_s;     % 2 for low qs variation
    alpha = alphaH(i,:) - gamma*grad;     
    i = i + 1;
end
i
alpha
alphaH(i,:) = alpha;