function squares_sum = method_1_loss(d, freq, v)
    nu = (freq(1) ./ freq).^2;
    H = v(1);
    c = v(2);
    a = v(3);
    
    squares_sum = sum((a * (1 - d ./ H).^4 + c - nu).^2);
end