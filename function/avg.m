function [y_avg, y_max, y_min]=avg(x)
    L=length(x);    % x 배열의 길이
    y_avg=sum(x)/L;
    y_max=max(x);
    y_min=min(x);
end

% 매트랩은 출력을 여러개로도 가능
% function [y, y_max, y_min] = avg()