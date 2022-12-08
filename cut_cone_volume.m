function vol = cut_cone_volume(b1, C, phi1, phi2, h)
    vol = 0;
    if h < C
        vol = 1/3 * pi * h * (b1^2 + b1 * (b1 + h * tan(phi1)) + (b1 + h * tan(phi1))^2);
    else
        R_v = b1 + C * tan(phi1);
        h2 = h - C;
        vol = 1/3 * pi * C * (b1^2 + b1 * R_v + R_v^2) + 1/3 * pi * h2 * (R_v^2 + R_v * (R_v - h2 * tan(phi2)) + (R_v - h2 * tan(phi2))^2);
end
    
