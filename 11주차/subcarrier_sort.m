function [output, H_idx]=subcarrier_sort(x,fft_pt,h,N_use)
% 채널의 주파수 응답의 크기대로 sorting
output=zeros(1,fft_pt);
x=[x, zeros(1, fft_pt-N_use)]; %사용되지 않는 subcarrier는 그 개수만큼 0
H=fft(h,fft_pt);
[B, H_idx]=sort(abs(H), 'descend');
output(H_idx)=x; %H_idx 순서대로 output에 x를 넣음

