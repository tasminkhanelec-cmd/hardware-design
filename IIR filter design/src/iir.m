clc
fc = 25000;
fs = 200000;

[b,a] = butter(8,fc/(fs/2),"low")

scale_bits = 20;
b_fixed = round(b * 2^scale_bits) 
a_fixed = round(a * 2^scale_bits)

figure
subplot(2,1,1)
zplane(b,a)
title('Pole Zero plot in floating point');
subplot(2,1,2)
zplane(b_fixed,a_fixed)
title('Pole Zero plot in fixed point');
%%
figure;
subplot(2,1,1)
freqz(b,a,[],fs)
ylim([-100 20]);

title('Frequency Response of the Butterworth Filter');

%%
Ts=1/fs;
n=0:999;
t=n*Ts;
x=1*sin(2*pi*150*t)+0.1*sin(2*pi*60000*t);
Vref = 3.3;

xq = (x / (Vref/2)) * (2^scale_bits);
xq_int = round(xq);
fid = fopen('input_signal.txt','w');
fprintf(fid,"%d\n",xq_int);
fclose(fid);

%%

[audioSignal,  originalFs] = audioread('E:\OneDrive - BUET\4-2\VLSI\IIR\scream.wav');
audioSignal = audioSignal(:, 1); 
if originalFs ~= fs
    audioSignal = resample(audioSignal, fs, originalFs);
end %audioread already normalized audio signal value

quantizedSignal = round(audioSignal * 2^scale_bits);
dlmwrite('input_signal.txt', quantizedSignal, 'delimiter', '\n', 'precision', '%.0f');

%%

% Load the quantized signal (from your previous step)
quantizedSignal = dlmread('input_signal.txt'); 

% Load the simulation results (output from the filter)
simResults = dlmread('filtered_signal.txt');  

% Time vector for plotting with respect to time
N = length(quantizedSignal);  % Number of samples
time = (0:N-1) / fs;          % Time vector

% Plot the signals with respect to time in a new figure
figure;
subplot(2, 1, 1);  
plot(time, quantizedSignal);
title('Quantized Input Signal (Time Domain)');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

subplot(2, 1, 2); 
plot(time, simResults);
title('Filtered Results (Time Domain)');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

%%

figure;
subplot(2, 1, 1);
[pxx_input, f_input] = pwelch(quantizedSignal, [], [], [], fs);
semilogx(f_input, 10*log10(pxx_input));
title('Power Spectral Density - Input Signal');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
grid on;
xlim([1 fs]);

subplot(2, 1, 2);
[pxx_output, f_output] = pwelch(simResults, [], [], [], fs);
semilogx(f_output, 10*log10(pxx_output));
title('Power Spectral Density - Filtered Signal');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
grid on;
xlim([1 fs]);

%%

fid = fopen('input_signal.txt', 'r');
line_count = 0;
while ~feof(fid)
    line = fgetl(fid);
    if ischar(line)
        line_count = line_count + 1;
    end
end
fclose(fid);
fprintf('Input file has %d lines\n', line_count);

%%

fid = fopen('input_signal.txt', 'r');
data = textscan(fid, '%s');
fclose(fid);
total_lines = length(data{1});
fprintf('Total lines in file: %d\n', total_lines);
if total_lines >= 5969
    fprintf('Line 5969: %s\n', data{1}{5969});
else
    fprintf('File only has %d lines\n', total_lines);
end