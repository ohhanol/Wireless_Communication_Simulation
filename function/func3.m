%% 과제3
% 임의의 짝수 개 원소의 벡터를 입력받아 절반 크기의 벡터를 출력하는 함수

function y=func3(x)
L=length(x);
y=zeros(1, L/2);

for n=1:1:L/2
    t=[x(2*n-1) x(2*n)];
    y(n)=sum(t);
end

end