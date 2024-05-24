clear
close all

SNR=0:10;

BER_all=zeros(size(SNR));   % case1 : all subcarrier
BER_half=zeros(size(SNR));  % case2 : half of the subcarrier
BER_sort=zeros(size(SNR));  % case3 : half of the subcarrier (Sort in descending order)
fft_pt = 256;
L_cp = 24;
N_use=128;                  % 사용할 subcarrier의 개수

h=[0.88 -0.44 -0.18];
loop=1000;

N_all=2*fft_pt; % 512
N_sub=2*N_use;  % 256

for i=1:length(SNR)
    for n = 1:loop
        % data generation
        msg_all=randint(1,N_all);   % 512
        msg_sub=randint(1,N_sub);   % 256
        
        % QPSK mapping
        x_all= QPSK_mapper(msg_all);
        x_sub=QPSK_mapper(msg_sub); % 128

        % subcarrier sorting
        % H_idx 순서대로 output을 x_sort에 넣음
        [x_sort,H_idx]=subcarrier_sort(x_sub, fft_pt, h, N_use);
        
        
        % x_sub 범위 작성
        % fft_pt 중 subcarrier의 크기 만큼만 사용
        x_sub(N_use+1:end)=0;   % 129 부턴 0
        

        % OFDM transmitter
        y_all=OFDM_tx(x_all, fft_pt, L_cp);
        y_half=OFDM_tx(x_sub, fft_pt, L_cp);
        y_sort=OFDM_tx(x_sort, fft_pt, L_cp);

        % Channel <Multifading>
        r_all=multipath_fading(y_all, h, SNR(i));
        r_half=multipath_fading(y_half, h, SNR(i));
        r_sort =multipath_fading(y_sort, h, SNR(i));
        
        % OFDM receiver
        s_all=OFDM_rx(r_all, h, fft_pt, L_cp);
        s_half=OFDM_rx(r_half, h, fft_pt, L_cp);
        s_sort=OFDM_rx(r_sort, h, fft_pt, L_cp);
        
        %subcarrier select
        y_h = s_half(1:N_use);
        y_select =subcarrier_selection(s_sort, H_idx, N_use);

        % QPSK demapping
        bit_all=QPSK_demapper(s_all);
        bit_half=QPSK_demapper(y_h);
        bit_sort=QPSK_demapper(y_select);
        
        % BER
        BER_all(i)=BER_all(i)+sum(abs(msg_all-bit_all))/N_all;
        BER_half(i)=BER_half(i)+sum(abs(msg_sub-bit_half))/N_sub;
        BER_sort(i)=BER_sort(i)+sum(abs(msg_sub-bit_sort))/N_sub;
    end
    BER_all(i)=BER_all(i)/loop;
    BER_half(i)=BER_half(i)/loop;
    BER_sort(i)=BER_sort(i)/loop;
end

semilogy(SNR, BER_all, 'r*-','LineWidth',2)
hold on
semilogy(SNR, BER_half, 'b^-','LineWidth',2)
hold on
semilogy(SNR, BER_sort, 'g^-','LineWidth',2)
hold on
xlabel('SNR(dB)')
ylabel('BER')
grid on
legend('subcarrier all', 'subcarrier half', 'subcarrier sort')
