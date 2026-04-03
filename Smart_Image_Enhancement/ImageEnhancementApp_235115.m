classdef ImageEnhancementApp_235115 < matlab.apps.AppBase

    properties (Access = public)
        UIFigure      matlab.ui.Figure
        GridLayout    matlab.ui.container.GridLayout
        LoadButton    matlab.ui.control.Button
        RunButton     matlab.ui.control.Button
        TaskDropdown  matlab.ui.control.DropDown
        ImageAxes     matlab.ui.control.UIAxes
        InfoText      matlab.ui.control.TextArea
        GammaSlider   matlab.ui.control.Slider
    end
    
    properties (Access = private)
        OriginalImage
        CurrentImage
    end
    
    methods (Access = private)
        
        function startupFcn(app)
            app.InfoText.Value = 'Welcome! Click Load Image to begin.';
        end
        
        function LoadButtonPushed(app, event)
            [file, path] = uigetfile({'*.jpg;*.png;*.bmp'});
            if file ~= 0
                img = imread(fullfile(path, file));
                if size(img,3) == 3
                    img = rgb2gray(img);
                end
                app.OriginalImage = img;
                app.CurrentImage = img;
                imshow(img, 'Parent', app.ImageAxes);
                title(app.ImageAxes, 'Original Image');
                app.InfoText.Value = sprintf('Loaded: %s\nSize: %dx%d', ...
                    file, size(img,1), size(img,2));
            end
        end
        
        function RunButtonPushed(app, event)
            if isempty(app.CurrentImage)
                uialert(app.UIFigure, 'Load image first!', 'Error');
                return;
            end
            
            app.InfoText.Value = 'Processing... Please wait.';
            drawnow;
            
            % Run integrated pipeline
            img = double(app.CurrentImage)/255;
            
            % Denoise
            img = imgaussfilt(img, 0.8);
            % CLAHE
            img = adapthisteq(uint8(img*255), 'ClipLimit', 0.03);
            % Gamma
            img = (double(img)/255) .^ 0.9;
            % Sharpen
            blur = imgaussfilt(img, 1.5);
            img = img + 0.6*(img - blur);
            
            final = uint8(255*max(0, min(1, img)));
            app.CurrentImage = final;
            
            imshow(final, 'Parent', app.ImageAxes);
            title(app.ImageAxes, 'Enhanced Image');
            app.InfoText.Value = 'Enhancement complete!';
        end
        
        function TaskDropdownValueChanged(app, event)
            task = app.TaskDropdown.Value;
            
            switch task
                case 'Task 6.1'
                    if ~isempty(app.OriginalImage)
                        task61_acquisition();
                    end
                case 'Task 6.2'
                    if ~isempty(app.OriginalImage)
                        task62_sampling_quantization(app.OriginalImage);
                    end
                case 'Task 6.3'
                    if ~isempty(app.OriginalImage)
                        task63_geometric_transforms(app.OriginalImage);
                    end
                case 'Task 6.4'
                    if ~isempty(app.OriginalImage)
                        task64_intensity_transforms(app.OriginalImage);
                    end
                case 'Task 6.5'
                    if ~isempty(app.OriginalImage)
                        task65_histogram_processing(app.OriginalImage);
                    end
            end
        end
    end
    
    methods (Access = public)
        function app = ImageEnhancementApp_235115()
            % Create UI
            app.UIFigure = uifigure('Name', 'Image Enhancement - 235115');
            app.UIFigure.Position = [100 100 1000 600];
            
            % Grid Layout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.RowHeight = {'fit', 'fit', '1x'};
            app.GridLayout.ColumnWidth = {'fit', 'fit', '1x', 'fit'};
            
            % Load Button
            app.LoadButton = uibutton(app.GridLayout, 'push');
            app.LoadButton.ButtonPushedFcn = @(src,event) LoadButtonPushed(app, event);
            app.LoadButton.Text = 'Load Image';
            app.LoadButton.Layout.Row = 1;
            app.LoadButton.Layout.Column = 1;
            
            % Run Button
            app.RunButton = uibutton(app.GridLayout, 'push');
            app.RunButton.ButtonPushedFcn = @(src,event) RunButtonPushed(app, event);
            app.RunButton.Text = 'Run Pipeline';
            app.RunButton.Layout.Row = 1;
            app.RunButton.Layout.Column = 2;
            
            % Task Dropdown
            app.TaskDropdown = uidropdown(app.GridLayout);
            app.TaskDropdown.Items = {'Task 6.1', 'Task 6.2', 'Task 6.3', ...
                'Task 6.4', 'Task 6.5', 'Task 6.6'};
            app.TaskDropdown.ValueChangedFcn = @(src,event) TaskDropdownValueChanged(app, event);
            app.TaskDropdown.Layout.Row = 1;
            app.TaskDropdown.Layout.Column = 3;
            
            % Axes for image
            app.ImageAxes = uiaxes(app.GridLayout);
            app.ImageAxes.Layout.Row = 3;
            app.ImageAxes.Layout.Column = [1 3];
            
            % Info text
            app.InfoText = uitextarea(app.GridLayout);
            app.InfoText.Layout.Row = 3;
            app.InfoText.Layout.Column = 4;
            
            startupFcn(app);
        end
    end
end