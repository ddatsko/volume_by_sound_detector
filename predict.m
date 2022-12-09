function [dom_frequency, volume] = predict(X, freq, amp, empty_freq, glass_volume, glass_height)
%         X: vector of predicted constants that may change in future.
%         current structure (8 values): 
%           - number of points during calibration including the 0 volume one
%           - frequency on 0 volume
%           - a for method 1
%           - a, b1, C, phi1, phi2 for method 3



    [~, argmax] = max(amp);
    dom_frequency = freq(argmax);
    
    % Some threshold here. If the frequency is close to the empty glass
    % frequency -- say that the glass is empty. Otherwise, if the frequency
    % is much higher -- just go to the highest possible value to notify the
    % problem
    if dom_frequency > empty_freq
        if dom_frequency > empty_freq + 10
            volume = glass_volume;
        else
            volume = 0;
        end
        return
    end
            
    nu = (empty_freq / dom_frequency) .^2;
    
    n_calibration_points = X(1);

    H_1 = X(2);
    c_1 = X(3);
    a_1 = X(4);
    
    alpha_2 = X(5);
    
    method_2_prediction = glass_volume * ((nu - 1) / alpha_2)^0.25;
    method_1_prediction = glass_volume + H_1 * (((nu - c_1) / a_1) ^ 0.25 - 1);
    
    dom_frequency = method_1_prediction;
    volume = method_2_prediction;
    
end