
% Go through each file in the directory
directory = '/home/mrs/records';
files = dir(fullfile(directory,'*.wav'));

dominant = zeros([1, length(files)]);



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

end

mls = [0, 100, 200, 300, 400, 470];

calibration = calibrate_from_measurements(dominant(1:3), mls(1:3), 500);


% objective = @(v) fit_func(d, dominant, [v(1), v(2), v(3)]);
% res = fminsearch(objective, [1000, 1, 5]);
% disp(res);

% H = res(1);
% c = res(2);
% a = res(3);


% y = log(nu - 1);
% x = log(mls / 500);
% 
% 
% al = 5;
% c = 1;
% scatter(mls, nu);
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