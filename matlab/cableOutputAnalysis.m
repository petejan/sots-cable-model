
% This file is part of the sots-cable-model distribution (https://github.com/petejan/sots-cable-model).
% Copyright (c) 2018 Peter Jansen
% 
% This program is free software: you can redistribute it and/or modify  
% it under the terms of the GNU General Public License as published by  
% the Free Software Foundation, version 3.
%
% This program is distributed in the hope that it will be useful, but 
% WITHOUT ANY WARRANTY; without even the implied warranty of 
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License 
% along with this program. If not, see <http://www.gnu.org/licenses/>.


% cable output processing, using sampled nodes at -first -last -connectors

fn='sofs8-sparfloat';
loadCases=readtable(['output/' fn '-simValue1.csv']);

load (['output/' fn '-n00.mat']);

fid = fopen(['output/' fn '.bom'],'r');
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
        bomNodes.nNodes(i) = n{4};
        i = i + 1;
    end
end


% find a name for every node
bomNodeIndex = zeros(bomNodes.node(1), 1);
for i=1:size(bomNodes.node,2)
    bomNodeIndex(bomNodes.node(i):-1:(bomNodes.node(i)-bomNodes.nNodes(i)+1)) = i;
end

% nodeN = NaN(1, numel(nodes));
% for k = 2:numel(nodes)
%     nn = find(bomNodes.node == nodes(k), 1);
%     n1 = find(bomNodes.node+1 == nodes(k), 1);
%     if (size(nn,2) ~= 0)
%         nodeN(k) = nn;
%     else
%         nodeN(k) = n1;
%     end 
% end
% bomNodes.name(end+1) = {'unknown'};
% nodeN(isnan(nodeN)) = size(bomNodes.name,2);
% leg = bomNodes.name(nodeN(~isnan(nodeN)));

filelist = strcat('output/', fn, '-n', num2str(loadCases.FILENO,'%02d'), '.mat');
nf = size(loadCases.FILENO,1);

figure(1); clf

tension_mean = nan(nf, size(nodes,1));
tension_max = nan(nf, size(nodes,1));
tension_min = nan(nf, size(nodes,1));
tension_std = nan(nf, size(nodes,1));
tension_period = nan(nf, size(nodes,1));
tension_zero = nan(nf, size(nodes,1));

% for each file, calculate load stats
for filen=1:nf
    file = filelist(filen,:);
    disp (file)

    sim_data = load(file);
    tension = sim_data.T_t + repmat(sim_data.T(sim_data.nodes)', size(sim_data.T_t,1), 1);
    
    [S,f] = pwelch(sim_data.T_t,256,71,256,1/sim_data.dt);
    
    m0 = sum(S(2:end,:))*f(2);
    fsq = f.^2;
    m2 = sum((S(2:end,:)).*fsq(2:end),1)*f(2);
    APD = sqrt(m0./m2);
    
    tension_mean(filen,:) = (mean(sim_data.T_t)+sim_data.T(sim_data.nodes)')';
    tension_max(filen,:) = (max(sim_data.T_t)+sim_data.T(sim_data.nodes)')';
    tension_min(filen,:) = (min(sim_data.T_t)+sim_data.T(sim_data.nodes)')';
    tension_std(filen,:) = std(sim_data.T_t)';
    tension_period(filen,:) = APD';
    tension_zero(filen,:) = sum(tension<10);

    figure(1); 
    plot(sim_data.x, sim_data.z, sim_data.x(sim_data.nodes), sim_data.z(sim_data.nodes), '.' ); hold on; grid on
end

filen = nf + 1;

sim_data = load(['output/' fn '-survival.mat']);
tension_max(filen,:) = (max(sim_data.T_t)+sim_data.T(sim_data.nodes)')';

% Fatigue analysis
%  calculate the number of cycles at each state
%  calculate the fatigue damage done at each state
%  sum the damage over all states for each item

deployment_days = 365;
deployment_sec = deployment_days * 24 * 3600;

% load items.mat

nodeInfo = readtable('node_types.xlsx');

% calculate the Palmgren-Miner calculation of number of cycle fatigue
% damage at each load case

item_y = nodeInfo.yf(~isnan(nodeInfo.qf)).*nodeInfo.yield_kg(~isnan(nodeInfo.qf))*9.81;
item_q = nodeInfo.qf(~isnan(nodeInfo.qf));

% life_deployment = zeros(size(tension_period,2), size(item_y,2));
% for i=1:size(tension_period,2)
%     tension_cycles_per_year=1./tension_period(:,i)'.*loadCases.PROB'/100*deployment_sec;
%     N=(sqrt(2)*tension_std(:,i)'./item_y).^item_q'.*gamma(1+item_q'/2).*tension_cycles_per_year';
%     sumN = sum(N,2);
%     life_deployment(i,:) = 1./sumN;
% end

tension_cycles_per_year = 1./tension_period .* loadCases.PROB/100 * deployment_sec;
ity = repmat(item_y, [1, size(tension_std,2), size(tension_std,1)]);
itq = repmat(item_q, [1, size(tension_std,2), size(tension_std,1)]);
its = permute(repmat(tension_std, [1, 1, size(item_y)]), [3 2 1]);
itc = permute(repmat(tension_cycles_per_year, [1, 1, size(item_y,1)]), [3 2 1]);

N1 = (sqrt(2) * its ./ ity) .^ itq .* gamma(1+itq/2) .* itc;
life_deployment1 = 1./sum(N1, 3);

%[zs, ia] = sort(z(nodes));
[ns, ia] = sort(nodes, 1, 'descend');

figure(1); 
plot(sim_data.x, sim_data.z, sim_data.x(sim_data.nodes), sim_data.z(sim_data.nodes), '*' ); hold on; grid on
title([fn ' mooring layout'])

node_names = bomNodes.name;

nNodes = size(node_names, 2);
tStep = (sim_data.z(bomNodes.node(end))-sim_data.z(bomNodes.node(1)))/nNodes;
tPosZ = sim_data.z(bomNodes.node(1)):tStep:sim_data.z(bomNodes.node(end))-tStep;
tPosX = 7500*ones(nNodes,1);

sampleNodes = ismember(bomNodes.node, sim_data.nodes);

text(tPosX, tPosZ, node_names, 'Interpreter', 'none')

plot([tPosX sim_data.x(bomNodes.node-round(bomNodes.nNodes/2))]', [tPosZ' sim_data.z(bomNodes.node-round(bomNodes.nNodes/2))]', '-.')

xlim([0 tPosX(1)+2000])

figure(2); clf
sh(1)=subplot(2,1,2);
plot(loadCases.SWH,tension_mean/1000, '*')
grid on; xlabel('swh (m)'); ylabel('mean, max load (kN)'); 
hold on; plot(loadCases.SWH,tension_max(1:end-1,:)/1000, '.')

sh(2)=subplot(2,1,1);
plot(loadCases.SWH,tension_std, '*')
title([fn ' load statistics']);
grid on; xlabel('swh (m)'); ylabel('stdev load (N)');
linkaxes(sh, 'x');

figure(3); clf
sh(1)=subplot(1,2,1);
plot(tension_std(:,ia)', z(nodes(ia))); xlabel('load std (N)');
grid on
sh(2)=subplot(1,2,2);
plot(tension_period(:,ia)', z(nodes(ia))); xlabel('load period (sec)');
grid on
linkaxes(sh, 'y');

figure(4); clf
plot(tension_max(:,ia)'/1000, z(nodes(ia))); xlabel('load max (kN)');
title([fn ' max load check plot'])
grid on

figure(6); clf
semilogx(life_deployment1, sim_data.z(nodes), '.'); grid on;
hold on; semilogx([4 4], [0 4500], '-');

nodeMsk = false(size(nodeInfo.modelItem, 1), size(nodes, 1));
for i=1:size(nodes, 1)
    nodeMsk(:, i) = ismember(nodeInfo.modelItem, bomNodes.name(bomNodeIndex(nodes(i))));
end

modelItems = nodeInfo.modelItem(~isnan(nodeInfo.qf));

itemMsk = false(size(modelItems,1), size(nodes, 1));
for i=1:size(modelItems, 1)
    itemMsk(i, :) = ismember(bomNodes.name(bomNodeIndex(nodes)), modelItems(i));
end

life_deployment2 = life_deployment1;
for i=1:size(life_deployment2,2)
    life_deployment2(itemMsk(:, i) == 0, i) = nan;
end

figure(5);
clf
semilogx(life_deployment1, -sim_data.z(nodes) + max(sim_data.z), '.', life_deployment2, -sim_data.z(nodes) + max(sim_data.z), '*'); grid on
xlim([1 1000]);
%legend(item, 'Interpreter', 'none')
title([fn ' component life']);
ylabel('depth (m)');
xlabel('life (years)');
hold on
semilogx([4 4], [0 2000], '-');
axis 'ij'

%tilefigs([], false);

life_deployment3 = life_deployment2;
life_deployment3(life_deployment3 > 100) = 100;

bn = bomNodes.name(bomNodeIndex);
tname = table(bn(nodes(ia))');

depths = num2str(-sim_data.z(nodes) + max(sim_data.z), '%.2f');
t = array2table(life_deployment2(:,ia)', 'VariableNames', matlab.lang.makeUniqueStrings(matlab.lang.makeValidName(nodeInfo.description(~isnan(nodeInfo.qf)))));
td = table(depths(ia,:), 'VariableNames', {'depth'});
t1 = [td tname t]

itmax = repmat(nodeInfo.swl_kg, [1, size(tension_max,2)]);
itmax(~nodeMsk) = NaN;
tmax = table(max(tension_max(:,ia))', 'VariableNames', {'max_load'});
tmin = table(min(tension_min(:,ia))', 'VariableNames', {'min_load'});
minswl = min(itmax);
tswl = table(minswl(ia)'*9.81, 'VariableNames', {'swl_N'});
margin = minswl(ia)./max(tension_max(:,ia))*9.81;
tmargin = table(margin', 'VariableNames', {'margin'});

figure(4); hold on
plot(itmax(:,ia)*9.81/1000, z(nodes(ia)), '*')

t2 = [td tname tmin tmax tswl tmargin]

writetable(t1, ['results/' fn '-res.xlsx'], 'sheet', 'sheet1');
writetable(t2, ['results/' fn '-res.xlsx'], 'sheet', 'sheet2');

plotfn = sprintf(['results/' fn '-Figures.ps']);
delete(plotfn);

figures = sort( double(findall(0, 'type', 'figure') ) );
% Generate figures
%[your code]
% Resize and output figures
figSize = [29, 21];            % [width, height]
figUnits = 'Centimeters';
for f = 1:size(figures,1)
      fig = handle(figures(f));
      % Resize the figure
      %set(fig, 'Units', figUnits);
      %pos = get(fig, 'Position');
      %pos = [pos(1), pos(4)+figSize(2), pos(3)+figSize(1), pos(4)];
      %set(fig, 'Position', pos);
      % Output the figure
      %filename = sprintf([fn '-Figure%02d.pdf'], f);
      
      print( fig, '-dpsc2', plotfn, '-append', '-fillpage');
end
