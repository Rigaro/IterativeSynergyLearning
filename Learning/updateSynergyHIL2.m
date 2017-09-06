if(i<2)
    alpha = alphaH(i) - 0.1;
    i = i + 1;
else
    dJ = JH(i)-JH(i-1);
    dalpha = alphaH(i)-alphaH(i-1);
    grad = dJ/dalpha;
    if(grad>10)
        grad = 10;
    elseif(grad<-10)
        grad = -10;
    end
    alpha = alphaH(i) - 2*grad;     % 2 for low qs variation
    i = i + 1;
end
% i
alphaH(i) = alpha;
% set_param('sim2DOFArmSynergySimulink/Synergy/alpha','Gain',num2str(alphaH(i)));