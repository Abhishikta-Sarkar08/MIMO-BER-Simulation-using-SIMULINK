clc
close all


model_name = 'siso_2_mimo'; 
% 1. Define the SNR (Eb/No) range in dB
snr_range = 0:1:14; 

% 2. Initialize arrays to store BER results
ber_path1 = zeros(size(snr_range));
ber_path2 = zeros(size(snr_range));

fprintf('Starting Simulation...\n');

for i = 1:length(snr_range)
    % Assign the current SNR value to the workspace variable
    snr_val = snr_range(i);
    
    
    % 'CaptureErrors' ensures the script doesn't stop if a sim error occurs
    sim_out = sim(model_name, 'CaptureErrors', 'on'); 
    
    % 4. Extract BER (The 1st element of the error rate vector)
    % We access the variables we named in the "To Workspace" blocks
    ber_path1(i) = sim_out.error_path1(1); 
    ber_path2(i) = sim_out.error_path2(1);
    
    fprintf('Processed SNR: %d dB | BER1: %f | BER2: %f\n', snr_val, ber_path1(i), ber_path2(i));
end

figure;
subplot(3,1,1)
    semilogy(snr_range, ber_path1, 'b-o', 'LineWidth', 1, 'MarkerSize', 13); 
    hold on;
    semilogy(snr_range, ber_path2, 'r-*', 'LineWidth', 1, 'MarkerSize', 9);
    
    grid on;
    xlabel('E_b/N_0 (dB)');
    ylabel('Bit Error Rate (BER)');
    title('BER vs SNR Comparison for Two Channels');
    legend('Channel Path 1', 'Channel Path 2');
    axis([min(snr_range) max(snr_range) 1e-4 1]); % Adjusts view range

subplot(3,1,2)
    plot(snr_range,ber_path1,'b-o', LineWidth=2);
    hold on;
    grid on;
    xlabel('E_b/N_0 (dB)');
    ylabel('Bit Error Rate (BER)');
    title('BER vs SNR for Channel1');
    
subplot(3,1,3)
    plot(snr_range,ber_path2,'r-o', LineWidth=2);
    hold on;
    grid on;
    xlabel('E_b/N_0 (dB)');
    ylabel('Bit Error Rate (BER)');
    title('BER vs SNR for Channel2');