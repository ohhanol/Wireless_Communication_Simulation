function y = randint(M,N)

x = rand(M,N);
y = zeros(M,N);
for m=1:M
    for n=1:N
        if x(m,n) >= 0.5
            y(m,n) = 1;
        else
            y(m,n) = 0;
        end
    end
end
