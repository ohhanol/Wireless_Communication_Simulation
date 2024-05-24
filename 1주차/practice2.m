x=0.01:0.01:2;

Y=exp(x);
plot(x,Y,'r-', 'LineWidth',2);

hold on
Z=log(x);
plot(x,Z, 'g-','LineWidth',2);
grid on;
xlabel('x');
ylabel('지수함수, 로그함수');
title('Compare exp/log gragh');
legend('exp(x)','log(x)');