function bomNodes = bomNames(fn)

fid = fopen(fn, 'r');
C = textscan(fid, '%[^\n]');
fclose(fid);
s = C{1};
i = 1;
bomNodes = struct;
for f = 1:size(s,1)
    n = textscan(s{f}, '%d %s %f %d %f %f %d');
    if (size(n{7},1) >= 1)
        bomNodes.name(i) = n{2};
        bomNodes.depth(i) = n{5};
        bomNodes.node(i) = n{7};
        i = i + 1;
    end
end

% nodeN = zeros(1, numel(nodes));
% for k = 2:numel(nodes)
%     nodeN(k) = find(nodes(k) == bomNodes.node,1);
% end
% nodeN(1) = 45;

end