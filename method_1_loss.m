function squares_sum = method_1_loss(d, freq, v)
    H = v(1);
    c = v(2);
    a = v(3);
    
    nu_0 = freq(1);
    
    freq = freq(d < H);
    d = d(d < H);
    
    nu = (nu_0 ./ freq).^2;
    if isempty(d)
        squares_sum = inf;
    else
        squares_sum = 1 / length(d) * sum((a * (1 - d ./ H).^4 + c - nu).^2);
    end
    
    
    
%     mls_pred = -H .* (((nu - c) ./ a) .^ 0.25 - 1);
%     squares_sum = sum((d - mls_pred).^2);
%     
end