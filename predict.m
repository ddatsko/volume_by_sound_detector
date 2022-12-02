function [dom_frequency, volume] = predict(X, freq, amp)
    [~, argmax] = max(amp);
    dom_frequency = freq(argmax);
    volume = freq(argmax) / 10;
     
end