function [sampling_results, quant_results] = task62_sampling_quantization(img)
figure('Name', 'Task 6.2: Sampling & Quantization (235115)');

% SAMPLING
scales = [0.25, 0.5, 1, 1.5, 2];
labels = {'0.25x', '0.5x', 'Original', '1.5x', '2x'};

for i = 1:5
    if scales(i) == 1
        sampled = img;
    else
        newSize = round(size(img)*scales(i));
        if scales(i) < 1
            sampled = imresize(img, newSize, 'bilinear');
        else
            sampled = imresize(img, newSize, 'bicubic');
            end
        end
        
        sampling_results(i).scale = scales(i);
        sampling_results(i).image = sampled;
        sampling_results(i).resolution = size(sampled);
        
        subplot(4, 5, i);
        imshow(sampled);
        title(sprintf('%s\n%dx%d', labels{i}, size(sampled,1), size(sampled,2)));
    end
    
    % QUANTIZATION
    bit_depths = [2, 4, 8];
    for i = 1:3
        levels = 2^bit_depths(i);
        step = 256/levels;
        quantized = uint8(floor(double(img)/step)*step);
        
        quant_results(i).bits = bit_depths(i);
        quant_results(i).levels = levels;
        quant_results(i).image = quantized;
       quant_results(i).mse = mean((double(img(:)) - double(quantized(:))).^2);
        
        subplot(4, 5, 5+i);
        imshow(quantized);
        title(sprintf('%d-bit (%d levels)\nMSE: %.1f', bit_depths(i), levels, quant_results(i).mse));
        
        subplot(4, 5, 10+i);
        imhist(quantized);
        title(sprintf('Hist: %d-bit', bit_depths(i)));
        xlim([0 255]);
    end
    
    % Summary
    subplot(4, 5, [13, 14, 15]);
    axis off;
    summary = sprintf(['SAMPLING & QUANTIZATION SUMMARY (235115)\n\n' ...
        'Sampling: 0.25x to 2x tested\n' ...
        'Quantization: 2-bit, 4-bit, 8-bit tested\n\n' ...
        'Key Findings:\n' ...
        '- Down-sampling loses detail\n' ...
        '- 2-bit causes severe banding\n' ...
        '- 8-bit provides smooth gradients']);
    text(0.1, 0.5, summary, 'FontSize', 10, 'Units', 'normalized');
    
    fprintf('Task 6.2 Complete: Sampling & Quantization analyzed\n');
end