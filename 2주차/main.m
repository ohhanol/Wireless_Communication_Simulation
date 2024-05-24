clear; clc;

N=1000; % 생성할 데이터 비트 수 (짝수여야 함)

% 1. Binary data 생성
x=randint(1,N); 

% 2. QPSK mapping (복소수 심볼 생성)
y=QPSK_mapper(x);


