function [signals, num_clu] = GetSignals( i_channel )
%GETSIGNALS 单信道数据，每200行表示一个类别
%   此处显示详细说明
% 添加数据路径
addpath(genpath('F:\MATLAB\Spike_wpdec\4.WP_Coefficient(new data)\data_spk'));
CellNum = [20 21 31 35 50 113 125 130 198 203];
num_clu = numel(CellNum);
clusters_i = cell(num_clu, 1);
% ni = 1/num_clu;
signals = [];
id = 1;
for i = CellNum
    FileName = ['cell_',num2str(i),'.spk.1'];
    FileID = fopen(FileName	, 'r');
    t = fread(FileID, 'int16'); % 针对i_channel可优化
    fclose(FileID);
    data_raw = reshape(t, [], 32, 32);  % n_spikes, 32_channels, 32_samples
    data_200 = permute(data_raw(1:200,:,:), [1, 3, 2]);
    clusters_i{id} = data_200;
    spike_i = clusters_i{id}(:,:,i_channel);
    id = id + 1;
    signals = [signals; spike_i];
 end

end

