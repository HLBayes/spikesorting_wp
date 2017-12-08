function demo_function()
%DEMO_FUNCTION 此处显示有关此函数的摘要
%   此处显示详细说明
Index = zeros(32,2);
mark = zeros(32, 14);
for i_channel = 1:32
    [signals, num_clu] = GetSignals( i_channel );
    sig_norm = mapminmax(signals, 0, 1); % 归一化:(xi-min(x))/(max(x)-min(x))
    SignalPara.signals = sig_norm;
    SignalPara.num_clu = num_clu;
    WpPara.WP_Name = 'coif4';
    WpPara.WP_Level = 3;
    [ JAl, len_signal ] = ComputeJAl( SignalPara, WpPara );
    JA = sum(JAl, 2)/len_signal;
    mark(i_channel,:) = BestBasis(JA, WpPara.WP_Level);
    [~, I] = max(JAl(:));
    [I_row, I_col] = ind2sub(size(JAl), I);
    Index(i_channel,1) = I_row;
    Index(i_channel,2) = I_col;
end
NameIndex = '实验数据/归一化-Index.mat';
NameMark = '实验数据/归一化-mark.mat';
% NameIndex = '实验数据/未归一化-Index.mat';
% NameMark = '实验数据/未归一化-mark.mat';
save(NameIndex, 'Index', '-v7.3');
save(NameMark, 'mark', '-v7.3');
load handel;
sound(y,Fs);

end

