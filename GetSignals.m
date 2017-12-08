function [signals, num_clu] = GetSignals( i_channel )
%GETSIGNALS ���ŵ����ݣ�ÿ200�б�ʾһ�����
%   �˴���ʾ��ϸ˵��
% �������·��
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
    t = fread(FileID, 'int16'); % ���i_channel���Ż�
    fclose(FileID);
    data_raw = reshape(t, [], 32, 32);  % n_spikes, 32_channels, 32_samples
    data_200 = permute(data_raw(1:200,:,:), [1, 3, 2]);
    clusters_i{id} = data_200;
    spike_i = clusters_i{id}(:,:,i_channel);
    id = id + 1;
    signals = [signals; spike_i];
 end

end

