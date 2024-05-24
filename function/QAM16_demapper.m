function x_hat = QAM16_demapper(r)
L=length(r);
x_hat=zeros(1,4*L);


% 1. constellation 확장
% 경계를 명확하게 만들기 위해 정규화 다시 풀어주기 (생략 가능)
r=r*sqrt(10);


% 2. 수신된 복소수에 대해 성상도와의 거리를 구한 뒤 가장 가까운 성상도로 decision
bits=[0 0 0 0;
    0 0 0 1; 
    0 0 1 0; 
    0 0 1 1; 
    0 1 0 0; 
    0 1 0 1; 
    0 1 1 0; 
    0 1 1 1; 
    1 0 0 0; 
    1 0 0 1; 
    1 0 1 0; 
    1 0 1 1; 
    1 1 0 0; 
    1 1 0 1; 
    1 1 1 0; 
    1 1 1 1;];         % 신호
const=[-3-3j; -3-1j; -3+3j; -3+1j; -1-3j; -1-1j; -1+3j; -1+1j; 3-3j; 3-1j; 3+3j; 3+1j; 1-3j; 1-1j; 1+3j; 1+1j;]; % 성상도

for n=1:L
    d=abs(const-r(n));  % 수신신호 r과 성상도 const와의 거리
    [Y,I]=min(d);    % Y에는 거리 최솟값이, I에는 최솟값 거리의 배열 위치가 저장됨
    x_hat(4*n-3:4*n)=bits(I,:); % decision한 위치 I에서의 신호 반환
end

end