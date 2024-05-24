% 벡터 a의 원소를 앞에서부터 4개씩 읽어서
% 이 값의 합을 구하여 벡터 b에 순서대로 저장

clear; clc;

a=rand(20,1);
b=zeros(5,1);

for k=1:5
    b(k)= sum(a(4*k-3:4*k));
end

disp(b);
