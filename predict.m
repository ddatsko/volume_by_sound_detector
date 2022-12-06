function [dom_frequency, d] = predict(X, freq, empty_freq, amp)
    [~, argmax] = max(amp);
    dom_frequency = freq(argmax);
    
    nu = (empty_freq / dom_frequency) .^2;
    
    H = X(1);
    c = X(2);
    a = X(3);
    
    
    if nu < c
        d = 0;
        return;
    end
    

    d = -H * (((nu - c) / a) ^ 0.25 - 1);
end