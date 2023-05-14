clc;
close all;
clear all;

% PART 1: Reading stereo audio file and preprocessing

process_file("Birds.wav");
process_file("Drum.wav");
process_file("Speech.wav");

% For reading and processing audio
function [audio_data, sample_rate] = process_file(filename)
    % Read audio file and obtain sampling rate
    [audio_data, sample_rate] = audioread(filename);
    % disp(sample_rate)
    
    % Add the audio's two channels if the audio is stereo
    [~, cols] = size(audio_data);  % or use audioinfo(filename).NumChannels
    if cols == 2
        audio_data = audio_data(:, 1) + audio_data(:, 2);
        % disp(filename + " is two channels.")
    end
    
    % Playing the audio file and creating a new file
    sound(audio_data, sample_rate);
    new_filename = 'new' + filename;
    audiowrite(new_filename, audio_data, sample_rate);
    
    % Plotting the audio waveform
    t = linspace(0, length(audio_data)/sample_rate, length(audio_data));
    plot(t, audio_data);
    title('Waveform of ' + filename);
    xlabel('Time (s)');
    ylabel('Relative Intensity');
end