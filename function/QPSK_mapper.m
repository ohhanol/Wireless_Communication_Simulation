function y=QPSK_mapper(x)
% x의 길이
N=length(x);

% 2bit씩 잘라서 복소수 심볼로 만들기
y=zeros(1, N/2);

for n=1:N/2
    two_bit=x(2*n-1:2*n);
    if two_bit == [0, 0]
        y(n)=(1+1j)/sqrt(2);
    elseif two_bit==[0, 1]
        y(n) = (-1+1j)/sqrt(2);
    elseif two_bit==[1, 1]
        y(n) = (-1-1j)/sqrt(2);
    else
        y(n) = (1-1j)/sqrt(2);
    end
end

end