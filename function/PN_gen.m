function PN = PN_gen(G,idx)

% spreading code generation and store
register = [1 0 1 0 1 0 1 1];
register(idx) = ~register(idx);
PN = zeros(1,G);
for i=1:G
    PN(i) = register(8);
    temp = register(4) + register(5) + register(6) + register(8);
    temp = mod(temp,2);
    for k=8:-1:2
        register(k) = register(k-1);
    end
    register(1) = temp;
end
PN = -2*PN+1;
