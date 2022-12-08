function loss = method_3_loss(freq, glass_height, volumes, v)
    % v: a, b1, C, phi1, phi2
    % If the amount of points is too small for fitting, should use some
    % default values outside of this function. 
    % e.g. phi1 = phi2 = 0. b1 = b2 = glass_volume / glass_height, C = 0,
    % glass_height or glass_height / 0.5
    % This should be done outside of this function
    
    a = v(1);
    b1 = v(2);
    C = v(3);
    phi1 = v(4);
    phi2 = v(5);
    
    nu = freq(1) ./ freq;
    % Firstly, estimate the h from the formula
    h_est = glass_height .* ((nu - 1) ./ a).^0.25;

    loss = 0;
    for i = 1:length(volumes)
        v_est = cut_cone_volume(b1, C, phi1, phi2, h_est(i));
        loss = loss + (v_est - volumes(i))^2;
    end
end
    
    
    
    
    
    