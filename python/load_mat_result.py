import scipy.io as sio
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import pandas as pd
import numpy as np
from scipy import signal

import glob
import re

bom_regex = re.compile(r"(\d{4}) *(\S*) *(\S*) *(\d*) *(\S*) *(\S*) *(\S*)$")

load_cases = pd.read_excel('sofs/load_case_data.xlsx')

# process all files in output directory ending in .mat
case_files = glob.glob('sofs/output/*.mat')

# read the bom file into a dict array
bom = []
with open(case_files[0].replace('.mat', '.bom')) as f:
    for line in f:
        result = bom_regex.match(line)
        if result:
            bom.append({'segment': result.group(2), 'nodes': int(result.group(4)), 'node': int(result.group(7))})

print(bom)

# make some figures
fig = go.Figure()
fig_std = make_subplots(rows=2, cols=1, shared_xaxes=True)
fig_stats = make_subplots(rows=1, cols=2, shared_yaxes=True)
fig_spec = go.Figure()

# TODO: Map between load_case id and case file
T_std = []
APD = []
n = 0
for f in case_files:
    print('file : ', f)

    res = sio.loadmat(f)

    nodes = np.squeeze(res['nodes']).astype(int)-1

    df = pd.DataFrame({'x': np.squeeze(res['x']), 'z': np.squeeze(res['z']), 'T': np.squeeze(res['T'])})

    fs = 1/res['dt'][0][0]
    depth = res['depth'][0][0]

    t = np.squeeze(res['t'])
    T_t = res['T_t']
    T_std.append(np.std(T_t, axis=0))
    T_max = np.max(T_t, axis=0)+df['T'][nodes]
    T_min = np.min(T_t, axis=0)+df['T'][nodes]

    #fig_std.add_trace(go.Scatter(x=[*range(0, len(T_std[n]))], y=T_std[n], mode='markers', name='nodes'))
    fig_std.add_trace(go.Scatter(x=np.ones_like(T_std[n])*load_cases['SWH'][n], y=T_std[n], mode='markers', name='std'), row=1, col=1)
    fig_std.add_trace(go.Scatter(x=np.ones_like(T_std[n]) * load_cases['SWH'][n], y=T_max, mode='markers', name='max', marker_color="blue"), row=2, col=1)
    fig_std.add_trace(go.Scatter(x=np.ones_like(T_std[n]) * load_cases['SWH'][n], y=T_min, mode='markers', name='min', marker_color="lightskyblue"), row=2, col=1)
#    fig_std.add_trace(go.Scatter(y=T_t[:,0], x=t, mode='markers', name='nodes'))
    fig_std.update_yaxes(range=[0, None], row=1, col=1)

    fig.add_trace(go.Scatter(x=df['T'], y=df['z'], mode='lines', name='lines'))
    fig.add_trace(go.Scatter(x=df['T'][nodes], y=df['z'][nodes], mode='markers', name='nodes'))
    fig.update_xaxes(range=[0, None])
    fig.update_yaxes(range=[0, None])

    # calculate the spectrum for each node
    f, S = signal.welch(T_t, fs, nperseg=256, nfft=256, noverlap=71, axis=0, window='hamm')
    # for i in range(Pxx_den.shape[1]):
    fig_spec.add_trace(go.Scatter(x=f, y=10*np.log10(S[:, 1]), mode='lines', name=str(1)))

    # calculate the load period for each mode along the line
    m0 = np.sum(S[2:-1, :], axis=0) * f[1]
    fsq = np.power(f, 2)
    m2 = np.sum(np.tile(fsq[2:-1], reps=(98, 1)) * S[2:-1, :].transpose(), axis=1) * f[1]
    APD.append(np.sqrt(m0 / m2))

    # plot, order by node number (length along line)
    depth_order = np.argsort(nodes)
    fig_stats.add_trace(go.Scatter(x=T_std[n][depth_order], y=df['z'][nodes].values[depth_order], mode='lines+markers', name='std'+str(n)), row=1, col=1)
    fig_stats.add_trace(go.Scatter(x=APD[n][depth_order], y=df['z'][nodes].values[depth_order], mode='lines+markers', name='period'+str(n)), row=1, col=2)
    fig_stats.update_xaxes(range=[0, None])
    fig_stats.update_yaxes(range=[0, None])

    n = n + 1

fig.update_layout(template='plotly_white', xaxis_title="tension (N)", yaxis_title="z")
fig.show()
fig_std.update_layout(template='plotly_white', xaxis_title="SWH (m)", yaxis_title="load-std (N)")
fig_std.update_layout(template='plotly_white', xaxis_title="SWH (m)", yaxis_title="load (N)")
fig_std.show()
fig_spec.show()
fig_stats.show()

# Fatigue analysis
#  calculate the number of cycles at each state
#  calculate the fatigue damage done at each state
#  sum the damage over all states for each item

# deployment_days = 365;
# deployment_sec = deployment_days * 24 * 3600;
#
# % load items.mat
#
# nodeInfo = readtable('node_types.xlsx');
node_info = pd.read_excel('sofs/node_types.xlsx')
#
# % calculate the Palmgren-Miner calculation of number of cycle fatigue
# % damage at each load case
#
# item_y = nodeInfo.yf(~isnan(nodeInfo.qf)).*nodeInfo.yield_kg(~isnan(nodeInfo.qf))*9.81;
# item_q = nodeInfo.qf(~isnan(nodeInfo.qf));
#
# % life_deployment = zeros(size(tension_period,2), size(item_y,2));
# % for i=1:size(tension_period,2)
# %     tension_cycles_per_year=1./tension_period(:,i)'.*loadCases.PROB'/100*deployment_sec;
# %     N=(sqrt(2)*tension_std(:,i)'./item_y).^item_q'.*gamma(1+item_q'/2).*tension_cycles_per_year';
# %     sumN = sum(N,2);
# %     life_deployment(i,:) = 1./sumN;
# % end
#
# tension_cycles_per_year = 1./tension_period .* loadCases.PROB/100 * deployment_sec;
# ity = repmat(item_y, [1, size(tension_std,2), size(tension_std,1)]);
# itq = repmat(item_q, [1, size(tension_std,2), size(tension_std,1)]);
# its = permute(repmat(tension_std, [1, 1, size(item_y)]), [3 2 1]);
# itc = permute(repmat(tension_cycles_per_year, [1, 1, size(item_y,1)]), [3 2 1]);
#
# N1 = (sqrt(2) * its ./ ity) .^ itq .* gamma(1+itq/2) .* itc;
# life_deployment1 = 1./sum(N1, 3);
