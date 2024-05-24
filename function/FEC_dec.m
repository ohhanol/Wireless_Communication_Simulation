function data_ = FEC_dec(x,R)
L = length(x);
N=L/R;  % FEC encoding 하기 전 원래 데이터 길이
sum_ = zeros(1,N);  % 다수결 적용하기 위한 sum_ 배열 선언
data_ = zeros(1,N);

for n=1:R
    sum_ = sum_ + x(N*(n-1)+1:N*n);
    % 다수결 하기 위해 일단 다 더해서 누적하기. 0~R사이 값들로 채워질 거임
end

% 다수결 시작
for n=1:N
    if sum_(n) > R/2
        data_(n) = 1;
    else
        data_(n) = 0;
    end
end


end