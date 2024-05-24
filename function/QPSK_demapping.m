function QPSK_data = QPSK_demapper(CH_in)

L = length(CH_in);
QPSK_data = zeros(1, 2*L);

for n=1:L
    if real(CH_in(n))>=0 && imag(CH_in(n))>=0
        QPSK_data(2*(n-1)+1:2*n)=[0 0];
    elseif real(CH_in(n))<0 && imag(CH_in(n))>=0
        QPSK_data(2*(n-1)+1:2*n)=[0 1];
    elseif real(CH_in(n))<0 && imag(CH_in(n))<0
        QPSK_data(2*(n-1)+1:2*n)=[1 1];
    else 
        QPSK_data(2*(n-1)+1:2*n)=[1 0];
    end
end
