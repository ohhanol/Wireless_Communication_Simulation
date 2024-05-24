clear; clc;

a=rand(1,1);

if a>0.5
    fprintf('a = %f\n', a);
    fprintf('high\n');
else
    fprintf('a = %f\n', a);
    fprintf('low\n');
end