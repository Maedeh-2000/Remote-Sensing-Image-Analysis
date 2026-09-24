% Remote Sensing Lab 1 
clear; clc; close all;

%% 1. Load image and metadata
imageFile = 'image.tif';
infoFile = 'info.mat';
load(infoFile);  

% Read multi-band image stored as one 3D array in a single page
t = Tiff(imageFile, 'r');
multiBandImage = t.read();   % Returns [rows, cols, bands]
t.close();

% Image dimensions
[rows, cols, numBands] = size(multiBandImage);
fprintf('\n--- Image Information ---\n');
fprintf('Image size: %d x %d pixels\n', rows, cols);
fprintf('Number of bands: %d\n', numBands);

%% 2. Show metadata (check bands)
if exist('info', 'var')
    if isfield(info, 'band_names')
        disp('Band names:');
        disp(info.band_names);
    end
    if isfield(info, 'wavelength')
        disp('Wavelengths:');
        disp(info.wavelength);
    end
end

%% 3. Grayscale preview of bands
figure('Name', 'Multispectral Band Preview');
for i = 1:min(6, numBands)
    subplot(2, 3, i);
    imagesc(multiBandImage(:, :, i)); axis off;
    colormap gray;
    title(['Band ', num2str(i)]);
end
sgtitle('Grayscale Preview of Multispectral Bands');
saveas(gcf, 'grayscale_band_preview.png');

%% 4. CIR Composite (Color Infrared)
NIR_idx = 8;    % NIR (842 nm)
RED_idx = 4;    % Red (665 nm)
GREEN_idx = 3;  % Green (560 nm)

NIR_band   = multiBandImage(:, :, NIR_idx);
Red_band   = multiBandImage(:, :, RED_idx);
Green_band = multiBandImage(:, :, GREEN_idx);

falseColorImg = cat(3, NIR_band, Red_band, Green_band);

% Apply contrast stretching
falseColorImg_disp = zeros(size(falseColorImg), 'like', falseColorImg);
for i = 1:3
    lowhigh = stretchlim(falseColorImg(:, :, i), [0.01 0.99]);
    falseColorImg_disp(:, :, i) = imadjust(falseColorImg(:, :, i), lowhigh);
end

% Display and save
figure('Name', 'False Color Composite');
imshow(falseColorImg_disp);
title('False Color Composite (CIR) – NIR, Red, Green');
imwrite(falseColorImg_disp, 'false_color_CIR.png');
disp('Saved false_color_CIR.png');

