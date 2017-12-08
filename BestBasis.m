function mark = BestBasis(J_A, WP_Level)
%UNTITLED 选择最优基
%   mark=1表示标记为选择的最优基
%   mark=2表示未被选择的基
% 
%   eg.
%       J_A = [11, 29, 2, 8, 12, 16, 1, 2, 3, 4, 5, 6, 7, 8];
%       WP_Level = 3;
%       mark = [2, 1, 2, 1, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2]
    node_num = numel(J_A);
    mark = zeros(1, node_num);
%     WP_Level = 3;
    while WP_Level>1
        % length = 2^(n+1);
        st = 2^WP_Level - 1;   % 7
        ed = 2^(WP_Level+1) - 2;   % 14
        st1 = 2^(WP_Level-1) - 1;  % 3
        ed1 = 2^WP_Level - 2;  % 6
        disp(['st=',num2str(st),',   ed=',num2str(ed),',   st1=',num2str(st1),',   ed1=',num2str(ed1)]);
        j = st1;
        for i=st:2:ed
            if(mark(i)==2 || mark(i+1)==2)
                if(mark(i)==2 && mark(i+1)==2)                
                    mark(j) = 2;
                elseif(mark(i)==2)
                    mark(i+1) = 1;
                    mark(j) = 2;
                else
                    mark(i) = 1;
                    mark(j) = 2;
                end
            elseif(J_A(i)+J_A(i+1)>J_A(j))
                mark(i) = 1;
                mark(i+1) = 1;
                mark(j) = 2;
            else
                mark(i) = 2;
                mark(i+1) = 2;
            end
            j = j+1;
        end
        WP_Level = WP_Level - 1;
    end
    if(mark(1)==2 || mark(2)==2)    % 不考虑0号位置节点
        if(mark(1)==2 && mark(2)==2)
            % mark(0) = 2;
        elseif(mark(1)==2)
            mark(2) = 1;
            % mark(0) = 2;
        else
            mark(1) = 1;
            % mark(0) = 2;
        end
    end
%     disp(mark);
       
end

