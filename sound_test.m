% Get data from the windows sound card (microphone) and
% display the frequency spectrum continuously.
% To run this demo:
%  1- Start --> Press "F5" to start
%  2- Work  --> Whistle into the microphone
%  3- Stop  --> Press "Ctrl+c" iside the MATLAB Command Window
%
% This is based on the MATLAB example "Acquiring Data with
% a Sound Card" of the "Data Acquisition Toolbox 2.10"
%
% Works on MATLAB v7.1.0.246(R14) with Data Acq. Toolbox v2.7
%
% By Nathir A Rawashdeh, March 2007
 
 
%%% User Parameters
duration = 1  % How many seconds of acquisition per plot refresh?
Fs = 8000     % Acquisition sample rate in Hz (try 8000)
% -------------------------------------------------------
 
 
 
%%% Initialization & configuration of sound card
AI = analoginput('winsound');
addchannel(AI, 1);
set (AI, 'SampleRate', Fs);
set(AI, 'SamplesPerTrigger', duration*Fs);
 
%%% Loop to get data and display it
% this "try" helps the program end
% properly when "ctr+c" is hit
try
    count = 0; % count how many time the while was executed
    while 1
        % increment loop counter
        count = count +1;
        % calculate elapsed time
        ET = duration * count;
 
        % start acquisition and retrieve data
        start(AI);
        data = getdata(AI);
 
        % Results: udate a FFT magnitude plot
        xfft = abs(fft(data));
        mag = 20*log10(xfft);  % Convert to dB
        mag = mag(1:end/2);    % duscard the redundant half
        figure(1010), plot([1:length(mag)]./duration,mag)
        title(['FFT Magnitude ; Seconds Elapsed = ' num2str(ET) ])
        xlabel('Hz'), ylabel('dB'), grid on, axis([0 400 -60 60])
 
    end
catch
    disp('--> coninuous loop was manually interrupted')
end
 
%%% Termination
disp('--> Deleting Analog Input Object')
stop(AI)
delete(AI)
 
 
 

