function output = fading(x, SNR)

z = sqrt(0.5*10^(-SNR/10))*(randn(1,length(x)) + 1j*randn(1,length(x)));
h = sqrt(0.5)*(randn(1,length(x)) + 1j*randn(1,length(x)));
y = h.*x + z;

output = y./h;