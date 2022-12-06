function loss = method_2_loss(h, freq, glass_volume, a)
    
    nu = (freq(1) ./ freq).^2;
    
    loss = sum((1 + a * (h ./ glass_volume).^4 - nu).^2);
end
