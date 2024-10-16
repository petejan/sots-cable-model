% process cable result files in directory,
% re-factor driven by simValue file

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

fn='sofs8-case1';

figure(7); clf; hold on
figure(4); clf; hold on

plotfn = sprintf(['results/' fn '-Figures.ps']);
delete(plotfn);

% read the load case file
M=readtable(['output/' fn '-simValue1.csv']);
filelist = strcat('output/', fn, '-n', num2str(M.FILENO,'%02d'), '.mat');
nf = size(M.FILENO,1);

% read the static solution
file = filelist(1,:);
disp (file)
sim_data_static=load (file);
depths = sim_data_static.depth-sim_data_static.z(sim_data_static.nodes);

load_mean = zeros(nf, size(sim_data_static.nodes,1));
load_sd = zeros(nf, size(sim_data_static.nodes,1));
load_period = zeros(nf, size(sim_data_static.nodes,1));
load_zeros = zeros(size(sim_data_static.nodes,1),1);

for filen=1:nf
    file = filelist(filen,:);
    disp (file)

    [m, s, p, z] = plotCableOutput(file);
    load_mean(filen,:) = m;
    load_sd(filen,:) = s;
    load_period(filen,:) = p;
    load_zeros = load_zeros + z';

    %h1 = figure(6);
    %title(['tension spectra, each component, SWH at ' num2str(M{filen,2}) ' period ' num2str(M{filen,3})]);
    %figure(100+filen);
    %h2 = gcf;
    %copyobj(allchild(h1),h2);

    figure(1);
    title(['load (N), each component, at SHW ' num2str(M{filen,2}) ' period ' num2str(M{filen,3})]);
    
    %figure(6);
    %print(plotfn, '-dpsc2', '-append');
    
    %pause
end

legendCell = cellstr(num2str(depths, '%.0f'));

% SOFS-1 simulation

%sofs1_simloadm=[2000 2020 2050 2100 2150 2200 2250 2300 2350 2400 2450 2500 2550 2600 2700 2800 2900 3000]*4.4;
%sofs1_simswhd=[1.4 2.3 3.2 4.1 5.0 5.9 6.9 7.8 8.7 9.6 10.5 11.4 12.3 13.3 14.2 15.1 16.0 16.9];
%sofs1_simloadsd=[1783.6 2318.7 2630.9 2720.0 2809.2 2898.4 2898.4 2898.4 2898.4 2898.4 2898.4 2898.4 2898.4 2898.4 2853.8 2853.8 2853.8 2809.2];
%sofs1_simperiod=[0.5 0.48 0.45 0.43 0.42 0.4 0.38 0.37 0.36 0.34 0.32 0.31 0.30 0.29 0.28 0.27 0.26 0.25];
%sofs1_prob=[0.00 0.12 5.22 17.10 23.57 23.28 14.83 8.16 4.14 1.83 0.96 0.51 0.18 0.06 0.0034 0.01 0.01 0.02];

% load data from sofs-5

%sofs5_data=readtable('SOFS-5-waveLoadstats.xlsx');

%sofs5_swh = sofs5_data{:,1};
%sofs5_prob = sofs5_data{:,2};
%sofs5_swfreq = sofs5_data{:,3};
%sofs5_loadsd = sofs5_data{:,4};
%sofs5_loadperiod = sofs5_data{:,5};

figure(10); clf; 
sh10(1)=subplot(3,1,1); hold on
plot(M{:,2},load_sd(:,1),'*-'); grid on
%plot(sofs1_simswhd, sofs1_simloadsd); grid on;
%plot(sofs5_swh, sofs5_loadsd); grid on;
title('load, frequency vs wave height');
ylabel('std load (N)')

hold off

sh10(2)=subplot(3,1,2); hold on
plot(M{:,2},load_mean(:,1),'*-'); grid on
%plot(sofs1_simswhd, sofs1_simloadm); grid on;
ylim([0 15000]);
% legend(legendCell, 'Location', 'northeastoutside')
%xlabel('SWH (m)')
ylabel('mean load (N)')
legend('sim', 'WHOI');
hold off

sh10(3)=subplot(3,1,3); hold on
plot(M{:,2},1./load_period(:,1),'*-', M{:,2}, 1./M{:,3}); grid on
%plot(sofs1_simswhd, sofs1_simperiod); grid on;
%plot(sofs5_swh, sofs5_loadperiod); grid on;

xlabel('SWH (m)')
ylabel('frequency (Hz)')
legend('sim', 'swp', 'WHOI', 'SOFS-5');
hold off
%title('average period vs wave height');

% legend(legendCell(1), 'Location', 'northeastoutside')


load ('SOFS-load-stats.mat');
figure(5); clf
hold on
plot(bin, load_std);
plot(M{:,2},load_sd(:,1)/9.81,'*-');
grid on
legend(dep)
hold off

% Need also to check that the maximum load, 'suvival current' max sea state
% does not exceed the yeild strength of an item

% Fatigue analysis
%  calculate the number of cycles at each state
%  calculate the fatigue damage done at each state
%  sum the damage over all states for each item

deployment_days = 365;
deployment_sec = deployment_days * 24 * 3600;

load items.mat

% calculate the Palmgren-Miner calculation of number of cycle fatigue
% damage at each load case

life_deployment = zeros(size(load_period,2), size(item_y,2));
for i=1:size(load_period,2)
    cycle=1./load_period(:,i)'.*M.PROB'/100*deployment_sec;
    N=(sqrt(2)*load_sd(:,i)./item_y).^item_q.*gamma(1+item_q/2).*cycle';
    sumN = sum(N);
    life_deployment(i,:) = 1./sumN;
end

%figure(12)
%plot(life_deployment,depths,'o'); axis 'ij'; xlim([0 10]); xlim([0 10]); ylim([0 1000]); legend(item)
%grid on; ylabel('depth (m)'); xlabel('life deployments (years)');

cload_prob = M.PROB;
cswh = M.SWH;
cload_period = load_period(:,1);
cload_mean = load_mean(:,1);
cload_std = load_sd(:,1);

save (['results/' fn '-cable-load.mat'], 'cload_prob', 'cload_mean', 'cload_std', 'cload_period', 'cswh');

format short g

% read the nnode names from the BOM file

nn = bomNames(['output/' fn '.bom']);
nodes = sim_data_static.nodes;
nodeN = zeros(1, numel(nodes));
for k = 2:numel(nodes)
     nodeN(k) = find(nodes(k) == nn.node,1);
end
nodeN(1) = 1;

%
% create the max load table
%
node_names = readtable(['output/' fn '-nodes.csv']);
node_names.Properties.VariableNames={'node', 'item', 'bottom_length'};

% read the swl table
swls = readtable('node_types_2.csv', 'Delimiter', ',', 'HeaderLines', 1, 'ReadVariableNames', true, 'ReadRowNames',true);
node_swls = swls(node_names.item,:).swl_kg;

fatComp = [ swls(nn.name(nodeN)',:).t1 swls(nn.name(nodeN)',:).t2 swls(nn.name(nodeN)',:).t3 swls(nn.name(nodeN)',:).t4 swls(nn.name(nodeN)',:).t5 swls(nn.name(nodeN)',:).t6 swls(nn.name(nodeN)',:).t7 swls(nn.name(nodeN)',:).t8 swls(nn.name(nodeN)',:).t9 swls(nn.name(nodeN)',:).t10 swls(nn.name(nodeN)',:).t11];
fatComp(fatComp == 0) = nan;

%
% create fatigue table
%
N=matlab.lang.makeValidName(item);
at=array2table(life_deployment.*fatComp, 'VariableNames', N);
itemsNames = table(nn.name(nodeN)', 'VariableName',{'item'});

tab = [table(sim_data_static.depth-sim_data_static.z(sim_data_static.nodes),'VariableName',{'depth'}) itemsNames at table(load_zeros)];
disp(tab);
writetable(tab, ['results/' fn '-res.xlsx']) % , 'sheet', 'fatiguelife');


sim_data = load (['output/' fn '-survival.mat']);
max_T_N = (max(sim_data.T_s(node_names{:,1},:),[],2) + sim_data.T(node_names{:,1}));
maxStaticFact = max_T_N ./ sim_data.T(node_names{:,1});

tab = [node_names table((node_names{1,3} - node_names{:,3}),'VariableNames', {'top_length'}) table(sim_data_static.depth-sim_data_static.z(node_names{:,1}),'VariableName',{'static_depth'}) table(max_T_N, maxStaticFact, node_swls * 9.81 ./ max_T_N, 'VariableName', {'max_tension_N', 'max_div_static', 'swl_margin'})];
disp(tab)
writetable(tab, ['results/' fn '-res.xlsx'], 'sheet', 'max');

% create plot of fatigue life and max load, SWL of components
% log depth, log fatigue life between 0-100

figure(31); clf
plot(max_T_N/1000,sim_data_static.depth-sim_data_static.z(node_names{:,1}), '.-')
axis 'ij'
grid on
hold on
plot(node_swls*9.81/1000,sim_data_static.depth-sim_data_static.z(node_names{:,1}), '*')
xl=xlim();
xlim([0 xl(2)])
ylim([-100 5000]);
title([fn ' component max tensions']);
ylabel('depth (m)');
xlabel('tension (kN)');

figure(32); clf
semilogx(life_deployment.*fatComp, sim_data_static.depth-sim_data_static.z(sim_data_static.nodes), '*')
grid on
axis 'ij'
xlim([1 1000]);
legend(item, 'Interpreter', 'none')
title([fn ' component life']);
ylabel('depth (m)');
xlabel('life (years)');
hold on
semilogx([4 4], [0 2000], '-');

figure(12); clf
depth = max(sim_data_static.z);
%subplot(2,2,1);
plot(sim_data_static.x,sim_data_static.z-max(sim_data_static.z))
hold on
plot(sim_data_static.x(nodes),sim_data_static.z(nodes)-max(sim_data_static.z),'*')
title('static (no wave load) position z vs x');
yl = ylim();
%xlim([0 -yl(1)/100]);
ylim([yl(1) 10]);
%plot([(x(nodes(1:end-1))+x(nodes(2:end)))/2 2*ones(size(nodes(1:end-1),1),1)]', [(z(nodes(1:end-1))-depth+z(nodes(2:end))-depth)/2 -(0:depth/size(nodes(1:end-2),1):depth)']', ':b')
%plot([(x(nodes(1:end))) 2*ones(size(nodes(1:end-1),1),1)]', [(z(nodes(1:end))-depth)' -(0:depth/size(nodes(1:end),1):depth)]', ':b')
text(3500*ones(size(node_names,1),1), -((0:depth/size(node_names,1):(depth-depth/size(node_names,1)))), node_names.item, 'Interpreter', 'none')
grid on
xlim([0 4500])

% nn.depth = node_names{1,3} - node_names{:,3};
% nn.w_std(1:(size(nn.name,2))) = nan;
% nn.w_std(nodeN) = sqrt(sum(sim_data.w_t.^2)/size(sim_data.w_t,1));
% 
% nn.u_std(1:(size(nn.name,2))) = nan;
% nn.u_std(nodeN) = sqrt(sum(sim_data.u_t.^2)/size(sim_data.u_t,1));
% nn.life(nodeN) = life_deployment;
% 
% nn.life = zeros(size(nn.name,2), size(life_deployment,2))*NaN;
% nn.life(nodeN,:) = life_deployment .* fatComp;
% nn.at = array2table(nn.life, 'VariableNames', N);
% nn.max = table(max_T_N, maxStaticFact, node_swls * 9.81 ./ max_T_N, 'VariableName', {'max_tension_N', 'max_div_static', 'swl_margin'});
% 
% t = [table(nn.name',nn.depth,nn.w_std', nn.u_std', 'VariableNames', {'name','depth', 'w_rms', 'u_rms'}) nn.at nn.max]
% 
% 
% node_to_plot = 8;
% figure(60); clf
% sb60(1) = subplot(2,1,1);
% plot(sim_data.t, sim_data.u_t(:,node_to_plot))
% grid on
% hold on
% plot(sim_data.t, sim_data.w_t(:,node_to_plot))
% legend('w', 'u');
% xlabel('time (s)'); ylabel('velocity (m/s)');
% 
% sb60(2) = subplot(2,1,2);
% plot(sim_data.t, sim_data.z_t(:,node_to_plot))
% grid on
% hold on
% plot(sim_data.t, sim_data.x_t(:,node_to_plot))
% legend('z', 'x');
% linkaxes(sb60, 'x');
% xlabel('time (s)'); ylabel('displacement (m)');
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
      
      print( fig, '-dpsc2', plotfn, '-append');
end

tilefigs([],false)


