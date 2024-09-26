import scipy.io as sio
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import pandas as pd
import numpy as np
from scipy import signal

import glob
import re

bom_regex = re.compile(r"(\d{4}) *(\S*) *(\S*) *(\d*) *(\S*) *(\S*) *(\S*)$")

load_cases = pd.read_excel('load_case_data.xlsx')

case_files = glob.glob('output/*.mat')

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
    T_std = np.std(T_t, axis=0)
    T_max = np.max(T_t, axis=0)+df['T'][nodes]
    T_min = np.min(T_t, axis=0)+df['T'][nodes]

    #fig_std.add_trace(go.Scatter(x=[*range(0, len(T_std))], y=T_std, mode='markers', name='nodes'))
    fig_std.add_trace(go.Scatter(x=np.ones_like(T_std)*load_cases['SWH'][n], y=T_std, mode='markers', name='std'), row=1, col=1)
    fig_std.add_trace(go.Scatter(x=np.ones_like(T_std) * load_cases['SWH'][n], y=T_max, mode='markers', name='max', marker_color="blue"), row=2, col=1)
    fig_std.add_trace(go.Scatter(x=np.ones_like(T_std) * load_cases['SWH'][n], y=T_min, mode='markers', name='min', marker_color="lightskyblue"), row=2, col=1)
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
    m0 = np.sum(S[2:-1, :],axis=0) * f[1]
    fsq = np.power(f, 2)
    m2 = np.sum(np.tile(fsq[2:-1], reps=(98, 1)) * S[2:-1, :].transpose(), axis=1) * f[1]
    APD = np.sqrt(m0 / m2)

    # plot, order by depth
    depth_order = np.argsort(df['z'][nodes].values)
    fig_stats.add_trace(go.Scatter(x=T_std[depth_order], y=df['z'][nodes].values[depth_order], mode='lines+markers', name='std'), row=1, col=1)
    fig_stats.add_trace(go.Scatter(x=APD[depth_order], y=df['z'][nodes].values[depth_order], mode='lines+markers', name='period'), row=1, col=2)

    n = n + 1

fig.update_layout(template='plotly_white', xaxis_title="tension (N)", yaxis_title="z")
fig.show()
fig_std.update_layout(template='plotly_white', xaxis_title="SWH (m)", yaxis_title="load-std (N)")
fig_std.update_layout(template='plotly_white', xaxis_title="SWH (m)", yaxis_title="load (N)")
fig_std.show()
fig_spec.show()
fig_stats.show()

# fig = go.Figure()
# for i in range(Pxx_den.shape[1]):
#     fig.add_trace(go.Scatter(x=f, y=10*np.log10(Pxx_den[:,i]), mode='lines', name=str(i)))
# fig.show()

    # m0 = sum(S(2:end,:))*f(2);
    # fsq = f.^2;
    # m2 = sum((S(2:end,:)).*fsq(2:end),1)*f(2);
    # APD = sqrt(m0./m2);

