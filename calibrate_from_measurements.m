function X = calibrate_from_measurements(freq, volume, full_volume, glass_height, method_3_defaults)
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
        current structure (8 values): 
          - number of points during calibration including the 0 volume one
          - frequency on 0 volume
          - a for method 1
          - a, b1, C, phi1, phi2 for method 3

        method_3_defaults:
          - Values for method 3 calibration that should not be estimated
          from the data but are set by defauser. If value is NaN, it will be
          deduced during oprimization
           - values order:
               b1, C, phi1, phi2  (NOTE that a can not be set here)
      
    %}
    % Set the first element of X to number of calibration points
    n_points = length(freq);
    X = [n_points];
    
    
    % Fit the model for the first, simplified method
    init_alpha = 5; % Some approximation for the initial value of the constant
    objective_2 = @(alpha) method_2_loss(volume, freq, full_volume, alpha);
    method_2 = fminsearch(objective_2, [init_alpha]);
    
    X = [X, method_2];
    
    init_a = 0.1;
    init_b1 = 1;
    init_C = 5;
    init_phi1 = 0.1;
    init_phi2 = 0.1;
    
    objective = @(v) method_3_loss(freq, glass_height, volume, compose_method_3_v(method_3_defaults, v));
    init_vs = [init_a, init_b1, init_C, init_phi1, init_phi2];
    init_vs = init_vs(isnan(method_3_defaults));
    
    method_3 = fminsearch(objective, init_vs);
    
    method_3_defaults(isnan(method_3_defaults)) = method_3;
    
    X = [X, method_3_defaults];
    
   
end


function method_3_v = compose_method_3_v(defaults, v)
    defaults(isnan(defaults)) = v;
    method_3_v = defaults;
end
