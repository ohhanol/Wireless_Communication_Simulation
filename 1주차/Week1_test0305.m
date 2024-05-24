x=2; y=3;
z=x+y;
exp(1j*x)
sin(x)+1j*cos(x)

%%
clear; clc;
x= 0:1:10
x_1=10:-1:0

%% 배열과 벡터의 차이
clear; clc;
x=[0, 1, 2, 3]     % x는 배열(array) = 행백터
%  , 생략하고 space로 구분해주기도 함
y=[0 1 2 3]'    % y는 벡터(vector) = 열벡터

size(x) % 1x4 벡터
size(y) % 4x1 벡터

z=[1;2;3;4] % [] 안에서 원소 뒤에 ; 찍으면 enter 와 같은 의미


X= [1, 2, 3; 4, 5, 6]   % 행렬
% C언어에서는 2차원 배열이라고 불렀음
% MATLAB에서는 그냥 행렬!

%% 입력(ex. x)이 벡터나 행렬이어도 동작한다
clear; clc;

x=0:30:180
sind(x)         % sin 0, sin30, sin60, sin90, sin120, sin150, sin180 한방에 구하고 싶을 때!!!!!!

% 매트랩은 1부터 인덱싱! 첫번째 원소 출력하려면 x[0]은 에러남  -> x(1) 로 입력해야 함
% 위치를 나타낼 때, 인덱싱할 때 소괄호 () 사용
x(1);
x(1:3);  % 부분벡터 subvector
x(1:2:5);    % 1부터 2씩 건너뛰어서 5까지

x(1:2:end)
x(end);

%% 부분행렬
clear; clc;
A=[1,2,3,4,; 5,6,7,8; 9, 10, 11, 12; 13, 14, 15, 16]

% 부분행렬 뽑아내기
A(1:2, 2:3) % 1~2행, 2~3열


%% C언어에 없는 유용한 문법
clc; clear;

a=[1,2,3]; b=[4, 5, 6];
% a*b 는 1x3 * 1x3 의 곱이므로 에러남
a*b'    % 이거는 1x3 * 3x1 이므로 1x1 상수 하나 계산됨

% ★★★★ 원소별 곱 ★★★★
a.*b    % 1x3 * 1x3 의 원소별 곱 = 1x3   , 크기가 같을 때 가능



%%
clear; clc;

a=[1,2,3];
b=[4,5,6];
c=a+b


%%
clear; clc;

figure(1);
x=0:10:360;
y=sind(x);  % sin0 sin10 sin20 sin30 ...
plot(x,y, 'bo-');
grid on;
xlabel('x');
ylabel('sin(x), cos(x)');

% 겹쳐서 cos 그리고 싶을 때
% 이전에 그렸던 그림 지우지 말고 잡고있어방 ..
hold on        % 주로 그림 그리기 직전에 씀
z=cosd(x);
plot(x,z, 'ro-');
legend('sin(x)', 'cos(x)');  % 그림 그린 순서대로



figure(2);
x=0:0.1:10;
y=0.5.^(x);  % 벡터 승은 동작하지 X . 연산을 해줘야 함
plot(x,y,'b-');  



% ★★ y축을 log scale 로 바꾸기!! y축 변화를 잘 보기 위함 ★★
figure(3);
semilogy(x,y,'b-', 'LineWidth',2);
grid on;


% 복소수로 그림 그릴 땐 자동으로 x축이 실수축, y축이 허수축이 됨!
figure(4);
x=[1+1j, -1+1j, -1-1j, 1-1j];
plot(x, 'bo');
axis([-1.5 1.5 -1.5 1.5]);
title('복소수 그림');

figure(5);
x=[0, 1, 2, 3];
plot(x, 'bo');


%% 실습 연습 정답!!!
fact=1;
for k=2:2:20
   fact=fact*k;
end



%% practice4.m 정답 !!
a=rand(20,1); % 0~1 사이 랜덤값
b=zeros(5,1);




%% for문! 많이 쓰여 ★★★★
clear; clc;
x=rand(18,1);
y=zeros(6,1);   % 변수 선언(초기화) 먼저 해주면 속도가 빠름! (에러는 안 남)

for k=1:6
    y(k)=sum(x(3*k-2:3*k));        % x(1:3), x(4:6), x(7:9), ... 
end

disp(y);




%%  if문 (practice5.m)
clear; clc;
a=rand(1,1);

if a>0.5
    fprintf('a = %f\n', a);
    fprintf('크다\n');
else
    fprintf('a = %f\n', a);
    fprintf('작다\n');
end











