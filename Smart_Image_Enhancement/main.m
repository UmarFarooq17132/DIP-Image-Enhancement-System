%% Smart Image Enhancement & Analysis System
% Student: Muhammad Umar Farooq (235115)

clear; clc; close all;

% Find project root (where code/functions exists)
if exist('/MATLAB Drive/Lab06_235115/code/functions', 'dir')
    basePath = '/MATLAB Drive/Lab06_235115';
elseif exist('./code/functions', 'dir')
    basePath = pwd;
elseif exist('../code/functions', 'dir')
    basePath = fullfile(pwd, '..');
else
    error('Cannot find code/functions folder');
end

% Convert to absolute path
basePath = char(java.io.File(basePath).getCanonicalPath);

% Add functions to path
addpath(fullfile(basePath, 'code', 'functions'));
cd(basePath);

fprintf('Working in: %s\n', basePath);
fprintf('========================================\n');
fprintf('SMART IMAGE ENHANCEMENT SYSTEM\n');
fprintf('Lab 06 - Muhammad Umar Farooq (235115)\n');
fprintf('========================================\n\n');

%% Run all tasks
[img_rgb, img_gray, initial_report] = task61_acquisition();
pause(2);

[sampling_results, quant_results] = task62_sampling_quantization(img_gray);
pause(2);

[transformed, restored] = task63_geometric_transforms(img_gray);
pause(2);

[intensity_results, best_method] = task64_intensity_transforms(img_gray);
pause(2);

[hist_results, equalized_img] = task65_histogram_processing(img_gray);
pause(2);

enhanced_image = task66_integrated_system(img_gray);

generate_report_235115(initial_report, sampling_results, quant_results, ...
    transformed, restored, intensity_results, best_method, hist_results);

fprintf('\n========================================\n');
fprintf('ALL TASKS COMPLETED!\n');
fprintf('========================================\n');