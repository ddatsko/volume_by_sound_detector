function X = calibrate_from_measurements(freq, volume, full_volume)
    d = full_volume - volume;
    
    % Initial values for the gradient descent
    H_init = 1000;
    a_init = 5;

    % Optimize the function with respect to parameters H, a and c,
    objective = @(v) fit_func(d, freq, [v(1), 1, v(2)]);
    X = fminsearch(objective, [H_init, a_init]);
end
    