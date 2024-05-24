function output= multipath_fading(x,h,SNR)
L=length(x);
L_h=length(h);
noise = sqrt(0.5*10^(-SNR/10))*(randn(1,L)+1j*randn(1,L));
output=zeros(size(x));
for n=1:L_h
    output=output+h(n)*delay(x,n-1); 
end
output=  output+noise; %잡음 더하기
