function [results, best_method] = task64_intensity_transforms(img)
figure('Name', 'Task 6.4: Intensity Transforms (235115)');

img_d = double(img)/255;

% Negative
subplot(3, 3, 1);
negative = 255 - img;
imshow(negative); title('Negative');
results.negative = negative;

% Double negative
subplot(3, 3, 2);
double_neg = 255 - negative;
imshow(double_neg); title('Double Negative');

    % Log transform
    subplot(3, 3, 3);
    c = 2;
    log_img = uint8(255*mat2gray(c*log(1+img_d)));
    imshow(log_img);
    title(sprintf('Log Transform (c=%.1f)', c));
    results.log = log_img;
    
    % Gamma transforms
    gammas = [0.4, 1.0, 2.5];
    for i = 1:3
        subplot(3, 3, 3+i);
        g_img = uint8(255*(img_d .^ gammas(i)));
        imshow(g_img);
        title(sprintf('Gamma = %.1f', gammas(i)));
        results.(['gamma_' num2str(gammas(i)*10)]) = g_img;
    end
    
    % Analysis
    subplot(3, 3, 7);
    means = [mean(img(:)), mean(negative(:)), mean(log_img(:)), ...
        mean(results.gamma_4(:)), mean(results.gamma_10(:)), mean(results.gamma_25(:))];
    bar(means);
    set(gca, 'XTickLabel', {'Orig','Neg','Log','γ0.4','γ1.0','γ2.5'});
    ylabel('Mean Intensity');
    title('Brightness Comparison');
    
    subplot(3, 3, 8);
    vars = [var(double(img(:))), var(double(negative(:))), var(double(log_img(:))), ...
        var(double(results.gamma_4(:))), var(double(results.gamma_10(:))), var(double(results.gamma_25(:)))];
    bar(vars);
    set(gca, 'XTickLabel', {'Orig','Neg','Log','γ0.4','γ1.0','γ2.5'});
    ylabel('Variance');
    title('Detail Enhancement');
    
    % Best methods
    [~, bright_idx] = max(means);
    [~, detail_idx] = max(vars);
    methods = {'Original','Negative','Log','Gamma0.4','Gamma1.0','Gamma2.5'};
    
    best_method.brightening = methods{bright_idx};
    best_method.detail = methods{detail_idx};
    
    subplot(3, 3, 9);
    imshow(results.gamma_4);
    title(sprintf('Best Brightening: %s', best_method.brightening));
    
    fprintf('Task 6.4 Complete: Intensity transforms analyzed\n');
    fprintf('  Best for Brightening: %s\n', best_method.brightening);
    fprintf('  Best for Detail: %s\n', best_method.detail);
end