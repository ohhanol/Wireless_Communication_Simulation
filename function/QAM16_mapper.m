function y = QAM16_mapper(x)
% N = x의 길이
N=length(x);

bit_combination=[0,0,0,0; 0,0,0,1; 0,0,1,0; 0,0,1,1; ...
    0,1,0,0; 0,1,0,1; 0,1,1,0; 0,1,1,1; 1,0,0,0; 1,0,0,1; ...
    1,0,1,0; 1,0,1,1; 1,1,0,0; 1,1,0,1; 1,1,1,0; 1,1,1,1;];

const_table=[-3-3j; -3-1j; -3+3j; -3+1j; -1-3j; -1-1j; -1+3j; ...
    -1+1j; 3-3j; 3-1j; 3+3j; 3+1j; 1-3j; 1-1j; 1+3j; 1+1j;]; % 성상도


% 4비트씩 잘라 심볼을 만들어서 y에 넣을거니까 y의 크기 1/4
y=zeros(1,N/4);

for n=1:1:N/4   % 4bit씩 끊어 읽어 맵핑해줄 거니까 N/4만큼 돌아야 함
    four_bit=x(4*n-3:4*n);      % 네 비트씩 자르기

    if four_bit == bit_combination(1,:)           % x에서 읽어들인 data가 0000 이면
        y(n)=const_table(1);                      % 복소수 심볼 y(n) 지정
    elseif four_bit == bit_combination(2,:)
        y(n)=const_table(2);
    elseif four_bit == bit_combination(3,:)
        y(n)=const_table(3);
    elseif four_bit == bit_combination(4,:)
        y(n)=const_table(4);
    elseif four_bit == bit_combination(5,:)
        y(n)=const_table(5);
    elseif four_bit == bit_combination(6,:)
        y(n)=const_table(6);
    elseif four_bit == bit_combination(7,:)
        y(n)=const_table(7);
    elseif four_bit == bit_combination(8,:)
        y(n)=const_table(8);
    elseif four_bit == bit_combination(9,:)
        y(n)=const_table(9);
    elseif four_bit == bit_combination(10,:)
        y(n)=const_table(10);
    elseif four_bit == bit_combination(11,:)
        y(n)=const_table(11);
    elseif four_bit == bit_combination(12,:)
        y(n)=const_table(12);
    elseif four_bit == bit_combination(13,:)
        y(n)=const_table(13);
    elseif four_bit == bit_combination(14,:)
        y(n)=const_table(14);
    elseif four_bit == bit_combination(15,:)
        y(n)=const_table(15);
    elseif four_bit == bit_combination(16,:)
        y(n)=const_table(16);
    end
end
y=y/sqrt(10);       % 정규화


end