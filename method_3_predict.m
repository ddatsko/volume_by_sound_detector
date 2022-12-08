function volume = method_3_predict(freq, empty_freq, glass_height, v)
    a = v(1);
    b1 = v(2);
    C = v(3);
    phi1 = v(4);
    phi2 = v(5);
    
    nu = empty_freq / freq;
    % Firstly, estimate the h from the formula
    h_est = glass_height * ((nu - 1) / a).^0.25;

    volume = cut_cone_volume(b1, C, phi1, phi2, h_est);

end