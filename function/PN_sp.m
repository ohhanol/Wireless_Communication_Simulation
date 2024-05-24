function y = PN_sp(x,SG,idx)
L = length(x);
y = zeros(1,L*SG);          %SG = 몇배로 늘릴건지?
code = PN_gen(SG,idx);           %모든 열

for n=1:L
    y(SG*(n-1)+1:SG*n) = x(n)*code;    
end

