function [ JAl, len_signal ] = ComputeJAl( SignalPara, WpPara )
%COMPUTEJA 由一维的spike，指定Wavelet package参数得到JA值
%   此处显示详细说明
signals = SignalPara.signals;
num_clu = SignalPara.num_clu;
WP_Name = WpPara.WP_Name;
WP_Level = WpPara.WP_Level;
len_signal = size(signals, 2);
dwtmode('per');
all_ni = size(signals,1);
ni = all_ni/num_clu;

All_x = cell(1, all_ni);
for k = 1:all_ni
   tree_si = wpdec(signals(k,:),WP_Level,WP_Name);
   x = zeros(2^(WP_Level+1)-2, len_signal);
   for m = 1:(2^(WP_Level+1)-2)
       x(m,:) = wprcoef(tree_si, m);
   end
   All_x{k} = x;
end
dwtmode('sym');
% Pi(1) = ni(1)/sum(ni);
% Pi(2) = ni(2)/sum(ni);
Pi = ni/all_ni;
Mi = cell(1,2^(WP_Level+1)-2);
M = zeros(2^(WP_Level+1)-2,len_signal);
for i_node =  1:(2^(WP_Level+1)-2)
    index_begin = 0;
    index_end = 0;
    count = 0;
    Mi_temp = zeros(num_clu, len_signal);
    M_temp = zeros(1,len_signal);
    for i = 1:num_clu
        Mi_k = zeros(1,len_signal);
        index_end = index_end + ni;
        for k = index_begin+1 : index_end
            count = count + 1;
            Mi_k = Mi_k + All_x{k}(i_node,:);
        end
        index_begin = count;
        Mi_temp(i,:) = Mi_k/ni;
        M_temp = M_temp + Pi*Mi_temp(i,:);
    end
    Mi{i_node} = Mi_temp;
    M(i_node,:) = M_temp;
end

JAl = zeros(2^(WP_Level+1)-2,len_signal);
for i_node = 1:(2^(WP_Level+1)-2)
    Sw = zeros(1,len_signal);
    Sb = zeros(1,len_signal);
    index_begin = 0;
    index_end = 0;
    count = 0;
    Sw_k = zeros(1,len_signal);
    for i = 1:num_clu
        index_end = index_end + ni;
        for k = index_begin+1 : index_end
          	count = count + 1;
            Sw_k = Sw_k + (All_x{k}(i_node,:)-Mi{i_node}(i,:)).*(All_x{k}(i_node,:) - Mi{i_node}(i,:));
        end
        index_begin = count;
        Sw = Sw + Pi*Sw_k/ni;
        Sb = Sb + Pi * ( (Mi{i_node}(i,:)-M(i_node,:)).*(Mi{i_node}(i,:)-M(i_node,:)) );
    end
    JAl(i_node,:) = Sb./Sw;
end


end

