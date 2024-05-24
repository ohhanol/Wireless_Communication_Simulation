function output = rake_hadamard(x,h,SG,idx)
L=length(x); % 입력 데이터의 길이
L_h=length(h); % 채널 계수의 길이
output=zeros(1,L/SG); 
H=hadamard(SG);
code=H(idx,:);

for n=1:L/SG
    for path=1:L_h
        output(n)=output(n)+conj(h(path))*x(SG*(n-1)+1:SG*n)*delay(code,path-1)'/SG;
    end
end
