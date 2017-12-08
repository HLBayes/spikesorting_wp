function demo_function()
%DEMO_FUNCTION �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
Index = zeros(32,2);
mark = zeros(32, 14);
for i_channel = 1:32
    [signals, num_clu] = GetSignals( i_channel );
    sig_norm = mapminmax(signals, 0, 1); % ��һ��:(xi-min(x))/(max(x)-min(x))
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
NameIndex = 'ʵ������/��һ��-Index.mat';
NameMark = 'ʵ������/��һ��-mark.mat';
% NameIndex = 'ʵ������/δ��һ��-Index.mat';
% NameMark = 'ʵ������/δ��һ��-mark.mat';
save(NameIndex, 'Index', '-v7.3');
save(NameMark, 'mark', '-v7.3');
load handel;
sound(y,Fs);

end

