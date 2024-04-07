%
%Data: Generate a series of five sequential sine wave signals for five seconds, each sine
%wave lasting 1 second. The nth sine wave signal xn = sin(2π · n · f), where f = 10, and
%n = 1, 2, 3, 4, 5, i.e., frequency 10Hz, 20Hz, 30Hz, 40Hz and 50Hz. The series is digitalized
%with a sampling rate is 200 Hz.
%Task:
%1. Draw a line plot of the series.
%2. Draw power spectrum (power density graph) of the series.
%3. Draw the spectrogram of the series.
%4. Draw and compare the ACF and PACF graphs of the first one-second (frequency
%10Hz) and the second one-second series (frequency 20Hz), with lags up to 50.
%

% Define sampling rate and duration
sampling_rate = 200; % Hz
duration = 1; % seconds

% Generate time points
t = linspace(0, duration, sampling_rate * duration);

% Define frequencies for each sine wave
frequencies = [10, 20, 30, 40, 50]; % Hz

% Initialize signal array
signals = zeros(length(t), length(frequencies));

% Generate each sine wave signal
for i = 1:length(frequencies)
    signals(:, i) = sin(2 * pi * frequencies(i) * t);
end

% Plot each sine wave signal
figure;
for i = 1:length(frequencies)
    subplot(length(frequencies), 1, i);
    plot(t, signals(:, i));
    title(['Sine Wave Signal ', num2str(i), ', f = ', num2str(frequencies(i)), ' Hz']);
    xlabel('Time (s)');
    ylabel('Amplitude');
end

%Task1
% Plot the series
figure;
plot(t, signals);
title('Sine Wave Signals');
xlabel('Time (s)');
ylabel('Amplitude');
legend('10 Hz', '20 Hz', '30 Hz', '40 Hz', '50 Hz');

%Task2
% Calculate power spectrum
nfft = 2^nextpow2(length(t)); % Next power of 2 from length of y
Y = fft(signals, nfft) / length(t);
frequencies1 = sampling_rate / 2 * linspace(0, 1, nfft / 2 + 1);

% Plot power spectrum
figure;
plot(frequencies1, 2 * abs(Y(1:nfft / 2 + 1, :)));
title('Power Spectrum (Power Density)');
xlabel('Frequency (Hz)');
ylabel('Power');
legend('10 Hz', '20 Hz', '30 Hz', '40 Hz', '50 Hz');

%Task3
figure;
for i = 1:length(frequencies)
    subplot(length(frequencies), 1, i);
    % Calculate spectrogram
    [s, f, t_spec] = spectrogram(signals(:,i))
    imagesc(t_spec, f, 10*log10(abs(s)));
    title(['Spectrogram of Signal ', num2str(i), ', f = ', num2str(frequencies(i)), ' Hz']);
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
end

%Task4
% Define the time vector for the one-second series
t_one_second = linspace(0, 1, sampling_rate);

% Extract the first one-second series (frequency 10Hz) and second one-second series (frequency 20Hz)
one_second_series_10Hz = sin(2 * pi * 10 * t_one_second);
one_second_series_20Hz = sin(2 * pi * 20 * t_one_second);

% Calculate ACF and PACF for both series
lags = 50;
[acf_10Hz, lag_10Hz] = autocorr(one_second_series_10Hz, lags);
[pacf_10Hz, lag_pacf_10Hz] = parcorr(one_second_series_10Hz, lags);
[acf_20Hz, lag_20Hz] = autocorr(one_second_series_20Hz, lags);
[pacf_20Hz, lag_pacf_20Hz] = parcorr(one_second_series_20Hz, lags);

% Plot ACF and PACF for both series
figure;
subplot(2, 2, 1);
stem(lag_10Hz, acf_10Hz, 'filled');
title('ACF of 10 Hz Series');
xlabel('Lag');
ylabel('Autocorrelation');

subplot(2, 2, 2);
stem(lag_pacf_10Hz, pacf_10Hz, 'filled');
title('PACF of 10 Hz Series');
xlabel('Lag');
ylabel('Partial Autocorrelation');

subplot(2, 2, 3);
stem(lag_20Hz, acf_20Hz, 'filled');
title('ACF of 20 Hz Series');
xlabel('Lag');
ylabel('Autocorrelation');

subplot(2, 2, 4);
stem(lag_pacf_20Hz, pacf_20Hz, 'filled');
title('PACF of 20 Hz Series');
xlabel('Lag');
ylabel('Partial Autocorrelation');