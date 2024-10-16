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

function [av, st, p, zeroCount] = plotCableOutput(file)

sim_data = load (file);

depth_nodes = sim_data.depth-sim_data.z(sim_data.nodes);

tension = sim_data.T_t + repmat(sim_data.T(sim_data.nodes)', size(sim_data.T_t,1), 1);
figure(1)
plot(sim_data.t, tension); grid on; title('load (N)'); ylim([0 30000]);
legendCell = cellstr(num2str(depth_nodes, '%.0f'));
legend(legendCell)

figure(2)
sh2(1)=subplot(3,1,1);
plot(sim_data.t, sim_data.z_t); grid on; title ('Z (m)');
%legend(legendCell, 'Location', 'northeastoutside')
sh2(2)=subplot(3,1,2);
plot(sim_data.t, sim_data.x_t); grid on; title ('X (m)');
sh2(3)=subplot(3,1,3);
plot(sim_data.t, tension); grid on; title('load (N)'); ylim([0 30000]);
linkaxes(sh2,'x');

zt = sim_data.z_t + repmat(sim_data.z(sim_data.nodes)', size(sim_data.z_t,1), 1);
figure(3)
%plot(x_t+repmat(x(nodes)', size(x_t,1), 1), z_t+repmat(z(nodes)', size(z_t,1), 1)-depth, '.',x, z-depth, x(nodes), z(nodes)-depth, '*'); grid on; title('mooring layout'); xlabel('distance from anchor (m)'); ylabel('depth (m)')
plot(sim_data.t*10, sim_data.T_t/20+repmat(sim_data.z(sim_data.nodes)', size(sim_data.T_t,1), 1)-sim_data.depth,sim_data.x, sim_data.z-sim_data.depth, sim_data.x(sim_data.nodes), sim_data.z(sim_data.nodes)-sim_data.depth, '*'); grid on; title('mooring layout'); xlabel('distance from anchor (m)'); ylabel('depth (m),T/20 (N)')

fig = figure(4);
plot(sim_data.T/1000, sim_data.depth-sim_data.z, sim_data.T(sim_data.nodes)/1000, depth_nodes, '*'); grid on; title('static load'); axis 'ij'
xlabel('tension (kN)'); fig.CurrentAxes.XScale = 'log';

%figure(5)
%plot(-T, depth-z, T_s, depth-z); grid on; axis 'ij'

load_std = std(sim_data.T_t(round(end/2):end,:));

% calc the load standard deviation and average load period using the
% spectra

%[S,f] = pwelch(sim_data.T_t,2560,710,2560,1/sim_data.dt);
[S,f] = pwelch(sim_data.T_t,256,71,256,1/sim_data.dt);
%[S,f] = pwelch(sim_data.T_s',2560,710,2560,1/sim_data.snap_dt);

figure(21);
imagesc(f,depth_nodes,10*log10(S'))
colorbar
caxis([-10 80]);
title(file);

%figure(22);
%[S1,f1] = pwelch(sim_data.T_s',256,71,256,1/sim_data.snap_dt);
%imagesc(f1,sim_data.depth-sim_data.z,10*log(S1'))

m0 = sum(S(2:end,:))*f(2);
fsq = f.^2;
m2 = sum((S(2:end,:)).*fsq(2:end),1)*f(2);
APD = sqrt(m0./m2);

figure(6);
pwelch(sim_data.T_t,256,71,256,1/sim_data.dt); ylim([-20 90]);

figure(7); 
sh7(1)=subplot(1,2,1); hold on
%plot(std(sim_data.T_s'),sim_data.depth-sim_data.z,'-',std(sim_data.T_t), depth_nodes,'*'); axis 'ij'; grid on; xlabel('load sd (N)'); ylabel('depth (m)');
plot(std(sim_data.T_t), depth_nodes,'-*'); axis 'ij'; grid on; xlabel('load sd (N)'); ylabel('depth (m)');
%plot(std(sim_data.Sn_t), depth_nodes,'-*'); axis 'ij'; grid on; xlabel('load sd (N)'); ylabel('depth (m)');
sh7(2)=subplot(1,2,2); hold on
plot(1./APD, depth_nodes,'*-'); axis 'ij'; grid on; xlabel('frequency (Hz)'); xlim([0 1]);
%plot(1./APD, sim_data.depth-sim_data.z,'-'); axis 'ij'; grid on; xlabel('frequency (Hz)');
linkaxes(sh7, 'y');
ylim([0 5000]);

%format short g
%['mean ' 'std ' 'period']
%[(mean(T_t)+T(nodes)')' std(T_t)' 1./APD']

av = (mean(sim_data.T_t)+sim_data.T(sim_data.nodes)')';
st = std(sim_data.T_t)';
p = APD';
zeroCount = sum(tension<10);

end
