function [img_rgb, img_gray, report] = task61_acquisition()
    % TASK 6.1: Image Acquisition and Understanding
    
    % Load image
    imagePath = '/MATLAB Drive/Lab06_235115/images/input/flower_235115.jpg';
    
    if exist(imagePath, 'file')
        img_rgb = imread(imagePath);
        fprintf('Loaded: flower_235115.jpg\n');
    else
        img_rgb = create_sample_image_235115();
    end
    
    % Convert to grayscale
    if size(img_rgb, 3) == 3
        img_gray = rgb2gray(img_rgb);
    else
        img_gray = img_rgb;
        img_rgb = cat(3, img_gray, img_gray, img_gray);
    end
    
    % Get properties
    [rows, cols, channels] = size(img_rgb);
    
    % Display - FIXED: shorter text
    figure('Name', 'Task 6.1: Image Acquisition (235115)');
    
    subplot(2, 3, 1); imshow(img_rgb); title('Original Image');
    subplot(2, 3, 2); imshow(img_rgb(:,:,1)); title('Red Channel');
    subplot(2, 3, 3); imshow(img_rgb(:,:,2)); title('Green Channel');
    subplot(2, 3, 4); imshow(img_rgb(:,:,3)); title('Blue Channel');
    subplot(2, 3, 5); imshow(img_gray); title('Grayscale');
    
    % FIXED: Shorter info text
    subplot(2, 3, 6);
    axis off;
    info = sprintf(['Image: %dx%d\n' ...
        'Channels: %d\n' ...
        'Type: %s\n' ...
        'Student: 235115'], ...
        rows, cols, channels, class(img_rgb));
    text(0.5, 0.5, info, 'FontSize', 12, 'HorizontalAlignment', 'center');
    
    % Report
    report.resolution = [rows, cols];
    report.channels = channels;
    report.data_type = class(img_rgb);
    report.bit_depth = 8;
    
    fprintf('Task 6.1 Complete: %dx%d\n', rows, cols);
end

function img = create_sample_image_235115()
    img = uint8(zeros(300, 300, 3));
    for i = 1:300
        for j = 1:300
            val = 100 + 60*sin(i/30)*cos(j/30);
            img(i,j,:) = val;
        end
    end
    img(80:150, 80:150, 1) = img(80:150, 80:150, 1) + 50;
    img(180:250, 180:250, 2) = img(180:250, 180:250, 2) + 60;
    noise = uint8(20*randn(300, 300, 3));
    img = imadd(img, noise);
    img = max(0, min(255, img));
    img = imadjust(img, [0.3 0.7], [0.2 0.8]);
end