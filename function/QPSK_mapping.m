function QPSK_symbol = QPSK_mapper(x)

L = length(x);
% L = x¿« ±Ê¿Ã(bits)
QPSK_symbol = zeros(1,L/2);

for n = 1:L/2
    two_bit = [x(2*n-1) x(2*n)];
    if two_bit == [0 0]
        QPSK_symbol(n) = sqrt(0.5) + j*sqrt(0.5);
    elseif two_bit == [0 1]
        QPSK_symbol(n) = -sqrt(0.5) + j*sqrt(0.5);
    elseif two_bit == [1 1]
        QPSK_symbol(n) = -sqrt(0.5) - j*sqrt(0.5);
    else
        QPSK_symbol(n) = sqrt(0.5) - j*sqrt(0.5);
    end
end
