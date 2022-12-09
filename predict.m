function [dom_frequency, method_2_volume, method_3_volume] = predict(X, freq, amp)
%         X: vector of predicted constants that may change in future.
%         current structure (8 values): 
%           - number of points during calibration including the 0 volume one
%           - frequency on 0 volume
%           - a for method 1
%           - a, b1, C, phi1, phi2 for method 3



    [~, argmax] = max(amp);
    dom_frequency = freq(argmax);
    empty_freq = X(2);
    glass_volume = X(9);
    glass_height = X(10);
    
    % Some threshold here. If the frequency is close to the empty glass
    % frequency -- say that the glass is empty. Otherwise, if the frequency
    % is much higher -- just go to the highest possible value to notify the
    % problem
    if dom_frequency > empty_freq
        if dom_frequency > empty_freq + 10
            method_2_volume = glass_volume;
            method_3_volume = glass_volume;
        else
            method_2_volume = 0;
            method_3_volume = 0;
        end
        return
    end
            
    nu = (empty_freq / dom_frequency) .^2;

    
    alpha_2 = X(3);
    
    method_2_volume = glass_volume * ((nu - 1) / alpha_2)^0.25;
    method_3_v = X(4:8);
    method_3_volume = method_3_predict(dom_frequency, empty_freq, glass_height, method_3_v);
    

    
end