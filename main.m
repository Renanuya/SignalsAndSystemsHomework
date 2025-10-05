clear; clc; close all;

id_number = input('TC Kimlik Numaranızı giriniz: ', 's');
student_number = input('Öğrenci Numaranızı giriniz: ', 's');

student_digits = fliplr(student_number);

for i = 1:length(student_digits)
    digit = str2double(student_digits(i));
    if digit ~= 0 && digit ~= 1
        factor = digit;
        break;
    end
end

if factor == 0
    error('Öğrenci numarasında 0 ve 1 dışında rakam bulunamadı!');
end

fprintf('\nBulunan faktör: %d\n', factor);
fprintf('Decimation faktörü (M): %d\n', factor);
fprintf('Expansion faktörü (L): %d\n', factor);

id_digits = arrayfun(@str2double, id_number(~isspace(id_number)));
N = length(id_digits);

n_original = 0:N-1;
x_original = id_digits';

fprintf('\n--- DECIMATION İŞLEMİ ---\n');

M = factor;
x_decimated = x_original(1:M:end);
n_decimated = 0:length(x_decimated)-1;

figure('Name', 'Decimation İşlemi', 'Position', [100, 100, 1200, 500]);

subplot(2,1,1);
stem(n_original, x_original, 'b', 'LineWidth', 1.5, 'MarkerSize', 8);
grid on;
xlabel('n');
ylabel('x[n]');
title(sprintf('Decimation Giriş Sinyali - %s', id_number));
set(gca, 'FontSize', 10);

subplot(2,1,2);
stem(n_decimated, x_decimated, 'r', 'LineWidth', 1.5, 'MarkerSize', 8);
grid on;
xlabel('n');
ylabel(sprintf('y_D[n]'));
decimated_str = sprintf('%d', x_decimated);
title(sprintf('Decimation Çıkış Sinyali - %s', decimated_str));
set(gca, 'FontSize', 10);

fprintf('--- EXPANSION İŞLEMİ ---\n');

L = factor;
x_expanded = zeros(1, length(x_original)*L);
x_expanded(1:L:end) = x_original;
n_expanded = 0:length(x_expanded)-1;

figure('Name', 'Expansion İşlemi', 'Position', [150, 150, 1200, 500]);

subplot(2,1,1);
stem(n_original, x_original, 'b', 'LineWidth', 1.5, 'MarkerSize', 8);
grid on;
xlabel('n');
ylabel('x[n]');
title(sprintf('Expansion Giriş Sinyali - %s', id_number));
set(gca, 'FontSize', 10);

subplot(2,1,2);
stem(n_expanded, x_expanded, 'g', 'LineWidth', 1.5, 'MarkerSize', 8);
grid on;
xlabel('n');
ylabel(sprintf('y_E[n]'));
expanded_str = sprintf('%d', x_expanded);
title(sprintf('Expansion Çıkış Sinyali - %s', expanded_str));
set(gca, 'FontSize', 10);

fprintf('\nOrijinal sinyal uzunluğu: %d\n', length(x_original));
fprintf('Decimation sonrası uzunluk: %d\n', length(x_decimated));
fprintf('Expansion sonrası uzunluk: %d\n', length(x_expanded));
fprintf('\nİşlem tamamlandı!\n');