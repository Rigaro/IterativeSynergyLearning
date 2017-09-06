h = 0.01;
gamma = 10;
if(i<2)
    deltaH(i) = 0;
else
    deltaH(i) = -h*deltaH(i-1)+JH(i)-JH(i-1);
end
if(deltaH(i)>10)
    deltaH(i) = 10;
elseif(deltaH(i)<-10)
    deltaH(i) = -10;
end
alpha = alphaH(i,:) + gamma*deltaH(i);     % 2 for low qs variation
i = i + 1;
i
alpha
alphaH(i,:) = alpha;