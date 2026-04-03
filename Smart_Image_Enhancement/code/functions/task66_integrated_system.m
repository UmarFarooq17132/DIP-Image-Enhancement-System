function enhanced_image = task66_integrated_system(img)
figure('Name', 'Task 6.6: Integrated System (235115)', 'Position', [50 50 1400 400]);

fprintf('  Running Enhancement Pipeline:\n');

% Stage 1: Original
subplot(1, 6, 1); imshow(img);
title(sprintf('1. Original\nMean:%.1f Std:%.1f', mean(double(img(:))), std(double(img(:)))));

% Stage 2: Denoise
fprintf('    Stage 2: Denoising...\n');
img_d = double(img)/255;
denoised = imgaussfilt(img_d, 0.8);
denoised_u8 = uint8(denoised*255);
subplot(1, 6, 2); imshow(denoised_u8);
title('2. Denoised');
    
    % Stage 3: CLAHE
    fprintf('    Stage 3: CLAHE...\n');
    contrast = adapthisteq(denoised_u8, 'ClipLimit', 0.03);
    subplot(1, 6, 3); imshow(contrast);
    title('3. CLAHE');
    
    % Stage 4: Gamma
    fprintf('    Stage 4: Gamma correction...\n');
    mean_int = mean(double(contrast(:)))/255;
    if mean_int < 0.45, gamma = 0.7;
    elseif mean_int > 0.65, gamma = 1.2;
    else, gamma = 0.9; end
    
    gamma_corr = (double(contrast)/255) .^ gamma;
    gamma_u8 = uint8(gamma_corr*255);
    subplot(1, 6, 4); imshow(gamma_u8);
    title(sprintf('4. Gamma (%.1f)', gamma));
    
    % Stage 5: Sharpen
    fprintf('    Stage 5: Sharpening...\n');
    blurred = imgaussfilt(gamma_corr, 1.5);
    sharpened = gamma_corr + 0.6*(gamma_corr - blurred);
    sharp_u8 = uint8(255*max(0, min(1, sharpened)));
    subplot(1, 6, 5); imshow(sharp_u8);
    title('5. Sharpened');
    
    % Stage 6: Final
    fprintf('    Stage 6: Final output...\n');
    final = imadjust(sharp_u8, stretchlim(sharp_u8, 0.01), []);
    enhanced_image = final;
    
    subplot(1, 6, 6); imshow(enhanced_image);
    title(sprintf('6. FINAL\nMean:%.1f Std:%.1f', ...
        mean(double(enhanced_image(:))), std(double(enhanced_image(:)))));
    
    % Save to output folder
    imwrite(enhanced_image, 'images/output/final_enhanced_235115.jpg');
    
    % Metrics
    psnr_val = psnr(enhanced_image, img);
    fprintf('  Pipeline complete!\n');
    fprintf('    PSNR: %.2f dB\n', psnr_val);
    fprintf('    Saved: images/output/final_enhanced_235115.jpg\n');
end