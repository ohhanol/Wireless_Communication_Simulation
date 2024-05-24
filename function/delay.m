function y = delay(x,k)

y = zeros(size(x));
y(k+1:end) = x(1:end-k);
if k > 0
    y(1:k) = x(end-k+1:end);
end