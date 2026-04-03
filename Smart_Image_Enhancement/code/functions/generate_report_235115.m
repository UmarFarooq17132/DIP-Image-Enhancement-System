function generate_report_235115(initial, sampling, quant, transformed, restored, ...
    intensity, best_method, hist)

fid = fopen('results/235115_Lab06_Report.txt', 'w');

fprintf(fid, '=====================================================\n');
fprintf(fid, 'SMART IMAGE ENHANCEMENT SYSTEM - Lab 06\n');
fprintf(fid, 'Student: Muhammad Umar Farooq (235115)\n');
fprintf(fid, 'Instructor: Mr. Ghulam Ali\n');
fprintf(fid, '=====================================================\n\n');

fprintf(fid, 'TASK 6.1 - IMAGE ACQUISITION\n');
fprintf(fid, 'Resolution: %dx%d, Channels: %d, Type: %s\n\n', ...
    initial.resolution(1), initial.resolution(2), ...
    initial.channels, initial.data_type);

    fprintf(fid, 'TASK 6.2 - SAMPLING & QUANTIZATION\n');
    fprintf(fid, 'Scales tested: 0.25x, 0.5x, 1x, 1.5x, 2x\n');
    fprintf(fid, 'Bit depths: 2-bit, 4-bit, 8-bit\n\n');
    
    fprintf(fid, 'TASK 6.3 - GEOMETRIC TRANSFORMS\n');
    fprintf(fid, 'Rotations: 30,45,60,90,120,150,180 degrees\n');
    fprintf(fid, 'Restoration MSE: %.2f\n\n', restored.mse);
    
    fprintf(fid, 'TASK 6.4 - INTENSITY TRANSFORMS\n');
    fprintf(fid, 'Best for Brightening: %s\n', best_method.brightening);
    fprintf(fid, 'Best for Detail: %s\n\n', best_method.detail);
    
    fprintf(fid, 'TASK 6.5 - HISTOGRAM PROCESSING\n');
    fprintf(fid, 'Contrast values: Orig=%.1f, Manual=%.1f, MATLAB=%.1f, CLAHE=%.1f\n\n', ...
        hist.contrast(1), hist.contrast(2), hist.contrast(3), hist.contrast(4));
    
    fprintf(fid, 'QUESTIONS & ANSWERS:\n\n');
    
    fprintf(fid, 'Q1: Why does histogram equalization improve contrast?\n');
    fprintf(fid, 'A: It redistributes intensities uniformly using CDF mapping,\n');
    fprintf(fid, '   spreading concentrated values across full [0,255] range.\n\n');
    
    fprintf(fid, 'Q2: How does gamma affect brightness?\n');
    fprintf(fid, 'A: Gamma < 1 brightens, Gamma = 1 no change, Gamma > 1 darkens.\n');
    fprintf(fid, '   Formula: s = r^gamma (non-linear power law)\n\n');
    
    fprintf(fid, 'Q3: Effect of quantization on quality?\n');
    fprintf(fid, 'A: Lower bits = fewer levels = visible banding/posterization.\n');
    fprintf(fid, '   8-bit=256 levels (good), 4-bit=16 levels (poor), 2-bit=4 levels (severe)\n\n');
    
    fprintf(fid, 'Q4: Which transformation is reversible?\n');
    fprintf(fid, 'A: Geometric transforms (rotation, translation, shear) are\n');
    fprintf(fid, '   reversible with inverse matrices, but interpolation causes small errors.\n\n');
    
    fprintf(fid, 'Q5: How do transforms affect spatial structure?\n');
    fprintf(fid, 'A: Rotation changes orientation, translation shifts position,\n');
    fprintf(fid, '   shearing distorts angles, all may introduce interpolation artifacts.\n\n');
    
    fprintf(fid, '=====================================================\n');
    fprintf(fid, 'END OF REPORT\n');
    fprintf(fid, '=====================================================\n');
    
    fclose(fid);
    
    fprintf('Report saved: results/235115_Lab06_Report.txt\n');
end