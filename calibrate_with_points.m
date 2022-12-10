
% Go through each file in the directory
directory = '/home/mrs/records/set2';
files = dir(fullfile(directory,'*.wav'));

dominant = zeros([1, length(files)]);


mls = [];

for i = 1:length(files)
  filename = files(i).name;
  disp(filename);
  full_name = fullfile(directory, filename);
  
  % Read the file
  [wav_data, fs] = audioread(full_name);
  ft = fft(wav_data(:, 1))';
  
  freq = 0:(fs / length(ft)):(fs / 2 - fs / length(ft));
  
  [argvalue, argmax] = max(ft(1:length(ft) / 2));
  dominant(i) = freq(argmax);
  
  % Get the amount of water from file name in format "<number>mls.wav"
  [s, e] = regexp(filename, '(\d+)');
  mls = [mls, str2num(filename(s:e))];
end




% objective = @(v) fit_func(d, dominant, [v(1), v(2), v(3)]);
% res = fminsearch(objective, [1000, 1, 5]);
% disp(res);

% H = res(1);
% c = res(2);
% a = res(3);
  

% Sort by frequency
tmp = [mls; dominant];
tmp = sortrows(tmp.',1).';
mls = tmp(1, :);
dominant = tmp(2, :);

mls_for_calib = [0, 40, 60, 80, 400];
% mls_for_calib = mls;
dominant_for_calib = mls == mls_for_calib(1);
for i = mls_for_calib
    dominant_for_calib = dominant_for_calib | (mls == i);
end


calibration = calibrate_from_measurements(dominant(dominant_for_calib), mls_for_calib, 500, 11, [nan, nan, nan, nan]);
calibration_2 = calibrate_from_measurements(dominant(dominant_for_calib), mls_for_calib, 500, 11, [1, 4, nan, nan]);
% objective = @(v) method_3_loss(dominant(dominant_for_calib), 11, mls_for_calib, v);
% method_3 = fminsearch(objective, [3.8, 2, 5, 0.1, 0.1]);


scatter(mls, dominant);





mls2_pred = [];
mls3_pred = [];
for freq = 250:590
   [~, m2, m3] =  predict(calibration_2, freq, 1);

   mls2_pred = [mls2_pred, m2];
   mls3_pred = [mls3_pred, m3];

end


e1 = 0;
e2 = 0;
e3 = 0;

for i = 1:length(dominant)
    freq = dominant(i);
    volume = mls(i);
    [~, m1, m2] =  predict(calibration, freq, 1);
    [~, ~, m3] = predict(calibration_2, freq, 1);
    e1 = e1 + abs(m1 - volume);
    e2 = e2 + abs(m2 - volume);
    e3 = e3 + abs(m3 - volume);
end
e1 = e1 / length(dominant);
e2 = e2 / length(dominant);
e3 = e3 / length(dominant);

    
fprintf("%.1f & %.1f & %.1f \\\\\n", [e1, e2, e3]);
    

hold on;
plot(mls3_pred, 250:590, 'r');
plot(mls2_pred, 250:590, 'b');
title("Calibration result");
xlabel("Water volume [ml]");
ylabel("Dominant frequency [Hz]");
legend("Measurements", "Method 1 prediction", "Method 2 prediction");

% 


% hold on;
% scatter(mls, c + al * (mls / 500).^4);
% % t = 50:1:500;

% plot(t,  (0.003*t).^3 + 1);

% al = 1;
% scatter(nu, 1 + al * ((mls / 500).^4));



% for i = 1:500
%     f = sum((a * (1 - d ./ H).^4 + c - nu).^2);
%     
%     ff = a * (1 - d ./ H).^4 + c - nu;
%     
%     da = sum(2 .* ff .* (1 - d ./ H).^4);
%     dc = sum(2 * ff);
%     dh = sum(2 .* ff .* 4 .* a .* (1 - d ./ H).^3 .* (d / H^2));
%     
%     
%     fprintf("%f, %f, %f, Error: %f \n", a, c, H, f);
%     if i < 100
%         k = 0.2;
%     else
%         k = 1 / i;
%     end
%     a = a - k * da;
%     H = H - k * 10000 * dh;
%     
% end


% plot(mls, nu);
% hold on;
% plot(mls, a * (1 - d ./ H).^4 + c);