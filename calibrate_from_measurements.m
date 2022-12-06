function X = calibrate_from_measurements(freq, volume, full_volume)
    %{
        Function for calibration from measurements.
        Produces the coefficients that will be then used in predict
        function.
        
        freq: array of measured dominant frequencies
        volume: array of coresponding volume of water in the glass.
            NOTE: volume should contain one zero, so there is a frequency
            of an empty glass on the volume array
        full_volume: full volume of the glass
        
        X: vector of predicted constants that may change in future.
        current structure (5 values): 
          - number of points during calibration including the 0 volume one
          - H*, c, a for the first method
          - a for the second, simplified method
        
    %}
    
    % Distance from the top of the glass in the original formulation
    d = full_volume - volume;
    
    % Initial values for the gradient descent
    H_init = 1000;
    c_init = 1;
    a_init = 5; 
   

    % Optimize the function with respect to parameters H, a and c,

    
    % If there are at least 3 points -- just fit the function as it is
    if length(freq) >= 3
        objective = @(v) method_1_loss(d, freq, [v(1), v(2), v(3)]);
        method_1 = fminsearch(objective, [H_init, c_init, a_init]);
    else
        % Other wise, fix c to 1 (which should be very close to the optimal one)
        % This way, only 2 parameters have to be guessed
        % If there are less than two points, the method will mostly give
        % wrong results, so its result is unlikely to be good
        objective = @(v) method_1_loss(d, freq, [v(1), 1, v(2)]);
        fitted = fminsearch(objective, [H_init, a_init]);
        method_1 = [fitted(1), 1, fitted(2)];
    end
    
    % Fit the model for the second, simplified method
    init_alpha = 5; % Some approximation for the initial value of the constant
    objective_2 = @(alpha) method_2_loss(volume, freq, full_volume, alpha);
    method_2 = fminsearch(objective_2, [init_alpha]);
    
    X = [length(freq), method_1, method_2];
   
end
