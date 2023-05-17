## Audio Processing in Matlab&reg;
A project for processing and analyzing audio recordings in Matlab&reg; with Audio Toolbox&trade;.
### Part 1
Stereo recordings are loaded into Matlab&reg; and exported as mono.
### Part 2
Three types of lowpass filters: moving average, median, and Gaussian filters, are designed with variable window sizes to reduce noise in audio recordings.

An example of the Gaussian filter being applied to the speech recording is shown in the following plot.
![Gaussian filter, window size 12](/GaussianFilteredSpeech.png?raw=true "Gaussian filter applied on speech recording, with window size of 12")
### Part 3
A signal peak detector is implemented for determining the number of syllables spoken in Speech.wav and the beats per minute of a high hat in Drum.wav. For Birds.wav, an algorithm is implemented for detecting and removing regions of the recording below a certain intensity.

Results of the silence removing algorithm is shown below, with a moving average filter applied to the same waveform alongside.
![Silence removal](/BirdsSilenceRemoved.png?raw=true "Silence removal algorithm applied to recording of birds")

## Remarks
Project description, as well as a short report on methodology and conclusions can be found in the included PDFs.

Completed in Fall 2022 as a course project for SYDE 252 Linear Systems and Signals course at the University of Waterloo.
