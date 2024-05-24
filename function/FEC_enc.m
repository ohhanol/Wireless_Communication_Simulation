function x = FEC_enc(data,R)

% Soliution 1. repmat 사용
x=repmat(data,1,R);

% Solution 2. for문 사용
% for n=1:R
%     FEC_enc_out(N*(n-1)+1:N*n)=x;
% end 

end