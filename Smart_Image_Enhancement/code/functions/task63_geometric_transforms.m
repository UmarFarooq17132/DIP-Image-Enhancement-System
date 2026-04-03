function [transformed, restored] = task63_geometric_transforms(img)
    % TASK 6.3: Geometric Transformations
    
    figure('Name', 'Task 6.3: Geometric Transforms (235115)');
    
    % Original
    subplot(3, 4, 1); imshow(img); title('Original');
    transformed.original = img;
    
    % Rotations - only print summary, not each iteration
    angles = [30, 45, 60, 90, 120, 150];
    rotated_images = cell(length(angles), 1);
    
    for i = 1:6
        rotated = imrotate(img, angles(i), 'bilinear', 'crop');
        rotated_images{i} = rotated;
        subplot(3, 4, i+1);
        imshow(rotated);
        title(sprintf('Rotate %d°', angles(i)));
    end
    
    % 180 degree
    subplot(3, 4, 8);
    rot180 = imrotate(img, 180, 'bilinear', 'crop');
    imshow(rot180); title('Rotate 180°');
    
    % Translation
    subplot(3, 4, 9);
    translated = imtranslate(img, [150, 100]);
    imshow(translated);
    title('Translation (150,100)');
    transformed.translated = translated;
    
    % Shearing
    subplot(3, 4, 10);
    tform = affine2d([1 0 0; 0.3 1 0; 0 0 1]);
    sheared = imwarp(img, tform, 'OutputView', imref2d(size(img)));
    imshow(sheared);
    title('Horizontal Shear');
    transformed.sheared = sheared;
    
    % Inverse rotation test - only calculate final MSE
    subplot(3, 4, 11);
    rot45 = imrotate(img, 45, 'bilinear', 'crop');
    restored_img = imrotate(rot45, -45, 'bilinear', 'crop');
    imshow(restored_img);
    title('Restored from 45°');
    restored.image = restored_img;
    
    % Calculate single MSE value
    restored.mse = mean((double(img(:)) - double(restored_img(:))).^2);
    
    subplot(3, 4, 12);
    error_img = abs(double(img) - double(restored_img));
    imshow(uint8(min(255, error_img * 3)));
    title(sprintf('Error (MSE: %.1f)', restored.mse));
    
    % Print only one summary line
    fprintf('Task 6.3 Complete: Geometric transforms\n');
    fprintf('  Restoration MSE: %.2f (interpolation error)\n', restored.mse);
end