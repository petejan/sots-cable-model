import scipy.io as sio
import plotly.graph_objects as go
import plotly.express as px
import pandas as pd
import numpy as np
from scipy import signal

import glob

load_cases = pd.read_excel('load_case_data.xlsx')

case_files = glob.glob('output/*.mat')

fig = go.Figure()
fig_std = go.Figure()

n = 1
for f in case_files:
    print('file : ', f)

    res = sio.loadmat(f)

    fs = 1/res['dt'][0][0]
    depth = res['depth'][0][0]

    t = np.squeeze(res['t'])
    T_t = res['T_t']
    T_std = np.std(T_t, axis=0)
    T_max = np.max(T_t, axis=0)
    T_min = np.min(T_t, axis=0)

    nodes = np.squeeze(res['nodes']).astype(int)-1

    df = pd.DataFrame({'x': np.squeeze(res['x']), 'z': np.squeeze(res['z']), 'T': np.squeeze(res['T'])})
#    fig_std.add_trace(go.Scatter(y=T_std, x=np.ones(load_cases.shape[0])*load_cases['SWH'][n], mode='markers', name='nodes'))
    fig_std.add_trace(go.Scatter(y=T_t[:,0], x=t, mode='markers', name='nodes'))

    fig.add_trace(go.Scatter(x=df['T'], y=df['z'], mode='lines', name='lines'))
    fig.add_trace(go.Scatter(x=df['T'][nodes], y=df['z'][nodes], mode='markers', name='nodes'))
    fig.update_xaxes(range=[0, None])
    fig.update_yaxes(range=[0, None])
    n = n + 1

fig.update_layout(template='plotly_dark', xaxis_title="x", yaxis_title="z")
fig.show()
fig_std.show()

# calculate the spectrum for each node
# f, Pxx_den = signal.welch(T_t, fs, nperseg=256, nfft=256, noverlap=71, axis=0)
# fig = go.Figure()
# for i in range(Pxx_den.shape[1]):
#     fig.add_trace(go.Scatter(x=f, y=10*np.log10(Pxx_den[:,i]), mode='lines', name=str(i)))
# fig.show()

    # m0 = sum(S(2:end,:))*f(2);
    # fsq = f.^2;
    # m2 = sum((S(2:end,:)).*fsq(2:end),1)*f(2);
    # APD = sqrt(m0./m2);

