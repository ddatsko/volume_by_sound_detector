function loss = method_2_loss(h, freq, glass_volume, a)
    %{ 
        Loss function of the second method
        h: predicted liquid level
        freq: real glass frequency
        glass_volume: real glass volume
        a: fitted constant
    %}
    nu = (freq(1) ./ freq).^2;

    loss = sum(abs(1 + a * (h ./ glass_volume).^4 - nu).^2);
end
