
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

nu = (dominant(1) ./ dominant).^2;
d = 500 - mls;

H = 1000;
c = 1;
a = 5;

for i = 1:500
    f = sum((a * (1 - d ./ H).^4 + c - nu).^2);
    
    ff = a * (1 - d ./ H).^4 + c - nu;
    
    da = sum(2 .* ff .* (1 - d ./ H).^4);
    dc = sum(2 * ff);
    dh = sum(2 .* ff .* 4 .* a .* (1 - d ./ H).^3 .* (d / H^2));
    
    
    fprintf("%f, %f, %f, Error: %f \n", a, c, H, f);
    k = 0.1;
    a = a - k * da;
    %c = c - k * dc;
    H = H - k * 10000 * dh;
    
end


plot(mls, nu);
hold on;
plot(mls, a * (1 - d ./ H).^4 + c);