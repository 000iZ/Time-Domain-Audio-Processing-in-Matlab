clc;
close all;
clear all;

% PART 2: Process audio signal by designing 3 types of low pass filters...
% A moving average filter, providing 1/L smoothing
% A median filter
% A weighted average/Gaussian filter

% Read the audio file(s)
%filename = "newBirds";
filename = "newDrum.wav";
%filename = "newSpeech";
[audio_data, sample_rate] = audioread(filename);

% Call a filtering function
% filtered_1 = mean_filter(audio_data, sample_rate, filename);
% filtered_2 = median_filter(audio_data, sample_rate, filename);
filtered_3 = gaussian_filter(audio_data, sample_rate, filename);
%sound(audio_data, sample_rate);
%sound(filtered_3, sample_rate);

% Moving average filter
function y = mean_filter(audio_data, sample_rate, filename)
    % Setting window size 
    window_size = 13;
    
    % Defining the 'numerator' coefficient for the filter transfer function
    % Note that b = [1/windowSize, 1/windowSize, ..., 1/windowSize]
    b = (1/window_size) * ones(1, window_size);
    
    % Using the filter function for filtering the audio signal
    % Note that the denominator is the second parameter
    y = filter(b, 1, audio_data);
    
    % Plotting the original unfiltered signal and the filtered signal
    label = "Average (L = " + window_size + ")";
    plot_audio(audio_data, y, sample_rate, label, filename);
end

% Moving median filter
function y = median_filter(audio_data, sample_rate, filename)    
    % Initializing y equal to input signal for now
    y = audio_data;
    
    % Setting window size
    window_size = 2;
    
    for n = window_size : length(audio_data)
        % Note that window_array is an array of x[n], x[n-1], ..., x[n-k]
        window_array = ones(1, window_size);
        for i = 0 : window_size-1
            window_array(i+1) = audio_data(n-i);
        end
        
        % Note that y[n] = median(x[n], x[n-1], x[n-2], ..., x[n-k])
        y(n) = median(window_array);
    end
    
    % Plotting the original unfiltered signal and the filtered signal
    label = "Median (L = " + window_size + ")";
    plot_audio(audio_data, y, sample_rate, label, filename);
end

% Moving weighted average filter
function y = gaussian_filter(audio_data, sample_rate, filename)
    % Setting window size    
    window_size = 10;
    
    % Setting weight coefficients using gausswin
    w = gausswin(window_size);
    w = w ./ sum(w);
    % disp(w);
    
    % Filtering using the filter function and the weights
    y = filter(w, 1, audio_data);
    
    % Plotting the original unfiltered signal and the filtered signal
    label = "Gaussian (L = " + window_size + ")";
    plot_audio(audio_data, y, sample_rate, label, filename);
end

% For plotting original and filtered waveforms together
function [] = plot_audio(x, y, sample_rate, label, filename)
    t = linspace(0, length(y)/sample_rate, length(y));
    plot(t, x, t, y);
    legend('Original Input', label);
    title('Original and Filtered Waveform of ' + filename);
    xlabel('Time (s)');
    ylabel('Relative Intensity');
end