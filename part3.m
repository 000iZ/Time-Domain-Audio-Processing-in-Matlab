clc;
close all;
clear all;

% PART 3: Create algorithms for...
% Detecting number of syllables in speech recording
% Detecting beats per minute of drum recording
% Removing silent regions from bird song recording

% find_syllables();
beats_per_minute();
% find_silent_regions();

% findSyllables reads in the newSpeech file and find number of syllables in
% the file
function [] = find_syllables()
    % Read in audio data
    [audio_data, sample_rate] = audioread('newSpeech.wav');
    disp(sample_rate);
    
    % Calling the mean filter
    y = mean_filter(audio_data, 10);
    
    % Finding peaks with minimum peak distance and minimum peak height
    % Minimum distance and height are tuned based on the filtered waveform
    pks = findpeaks(y, 'MinPeakDistance', 2500, 'MinPeakHeight', 0.075);
    
    % When min distance and height are tuned correctly, number of peaks
    % detected is the number of syllables
    disp(length(pks));
    
    % Plotting the filtered waveform for visual analysis
    t = linspace(0, length(y)/sample_rate, length(y));
    plot(t, y);
    title('Filtered Waveform ');
    xlabel('Time (s)');
    ylabel('Relative Intensity');
end

% Finds beats per minute from drum file
function [] = beats_per_minute()
    % Read in audio data for drum file
    [audio_data, sample_rate] = audioread('newDrum.wav');
    
    % Filter audio with mean filter
    y = mean_filter(audio_data, 3);

    % Get number of beats in the audio file
    peaks = findpeaks(y, 'MinPeakHeight', 0.1, 'MinPeakDistance', 1575);
    num_beats = length(peaks);
    disp("Number of beats in file: " + num_beats);

    % Convert number of beats in audio file to beats per minute using
    % length/time (s) of the file
    time_length_seconds = length(y) / sample_rate;
    bpm = (60 / time_length_seconds) * num_beats;
    disp("Predicted beats per minute: " + bpm);

    % Plotting the filtered waveform for visual analysis
    t = linspace(0, length(y)/sample_rate, length(y));
    plot(t, y);
    title('Filtered Waveform ');
    xlabel('Time (s)');
    ylabel('Relative Intensity');
end

% Finds silent regions
function [] = find_silent_regions()
    % Read in audio data for birds file
    [audio_data, sample_rate] = audioread('newBirds.wav');
    
    % Setting window size
    window_size = 3;
    legend_for_filtered = "Mean Filter (L = " + window_size + ")";

    % Filtering audio with mean filter
    y = mean_filter(audio_data, window_size);

    % Removing audio of relative intensity below a certain threshold 
    z = y;
    silence_threshold = round(abs(max(z)) * 0.1, 3);
    legend_for_silence_removed = "Silence Removed (I < " + ...
        silence_threshold + ")";  % here 'I' represents the intensity
    for i = 1 : length(z)
        if (abs(z(i)) < silence_threshold)
            z(i) = 0;  % pulling the intensity to 0 if it considered silent
        end
    end
    % sound(y, sample_rate)
    %sound(z, sample_rate)
    
    subplot(2, 1, 1);
    t = linspace(0, length(audio_data)/sample_rate, length(audio_data));
    plot(t, audio_data, t, y);
    title('Waveform with Moving Average Filter Applied');
    xlabel('Time (s)');
    ylabel('Relative Intensity');
    legend('Original Input', legend_for_filtered);

    subplot(2, 1, 2);
    plot(z, 'g');
    title('Waveform with Silent Regions Removed');
    xlabel('Time (s)');
    ylabel('Relative Intensity');
    legend(legend_for_silence_removed);

    size(y)
end


% Moving average filter (taken from part 2, but without audio plotting)
function y = mean_filter(audio_data, window_size)    
    % Defining the 'window' for the filtering
    % b = [1/windowSize, 1/windowSize, 1/windowSize]
    b = (1/window_size)*ones(1, window_size);
    
    % Using the filter function for filtering the audio signal with the
    % 'window'
    % Denominator (second parameter) is set to 1
    y = filter(b, 1, audio_data);    
end