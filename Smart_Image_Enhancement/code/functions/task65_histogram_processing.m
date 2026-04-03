function [results, equalized_img] = task65_histogram_processing(img)
figure('Name', 'Task 6.5: Histogram Processing (235115)');

% Original
subplot(3, 3, 1); imshow(img); title('Original');
subplot(3, 3, 2); imhist(img); title('Original Histogram'); xlim([0 255]);

hist_orig = imhist(img);
cdf_orig = cumsum(hist_orig)/numel(img);
subplot(3, 3, 3); plot(cdf_orig); title('Original CDF'); xlim([0 255]);

% Manual Histogram Equalization
pdf = hist_orig/sum(hist_orig);
cdf = cumsum(pdf);
mapping = uint8(255*cdf);
manual_eq = mapping(double(img)+1);
    
    subplot(3, 3, 4); imshow(manual_eq); title('Manual HE');
    subplot(3, 3, 5); imhist(manual_eq); title('Manual HE Hist'); xlim([0 255]);
    
    % MATLAB histeq
    matlab_eq = histeq(img);
    subplot(3, 3, 6); imshow(matlab_eq); title('MATLAB histeq()');
    
    % CLAHE
    clahe = adapthisteq(img, 'ClipLimit', 0.02);
    subplot(3, 3, 7); imshow(clahe); title('CLAHE');
    
    % Comparison
    subplot(3, 3, 8);
    c_orig = std(double(img(:)));
    c_man = std(double(manual_eq(:)));
    c_mat = std(double(matlab_eq(:)));
    c_cla = std(double(clahe(:)));
    bar([c_orig, c_man, c_mat, c_cla]);
    set(gca, 'XTickLabel', {'Orig','Manual','MATLAB','CLAHE'});
    ylabel('Std Dev (Contrast)');
    title('Contrast Comparison');
    
    % CDF comparison
    subplot(3, 3, 9);
    cdf_man = cumsum(imhist(manual_eq))/numel(manual_eq);
    cdf_mat = cumsum(imhist(matlab_eq))/numel(matlab_eq);
    plot(cdf_orig, 'b'); hold on;
    plot(cdf_man, 'r--');
    plot(cdf_mat, 'g:');
    legend('Orig','Manual','MATLAB');
    title('CDF Comparison');
    
    % Store results
    results.original = img;
    results.manual = manual_eq;
    results.matlab = matlab_eq;
    results.clahe = clahe;
    results.contrast = [c_orig, c_man, c_mat, c_cla];
    
    equalized_img = matlab_eq;
    
    fprintf('Task 6.5 Complete: Histogram processing done\n');
    fprintf('  Contrast improvement: %.1f%% (MATLAB HE)\n', ...
        ((c_mat-c_orig)/c_orig)*100);
end