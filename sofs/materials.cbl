Materials
    release_dual
        type=linear        diam=0.15        wet=351        mass=90.9091        length=1.94
        Cdn=1        Cdt=0.05        EA=5e+07           EI=82900        GJ=10000
        SWL=0        yield=0
        comment="EG&G 322 acoustic release - made up"
    balls_1/2in
        type=linear        diam=0.0475        wet=-217.5        mass=21.712        length=0
        Cdn=2.6        Cdt=0.7        EA=6e+07           EI=1.0        GJ=0.0001
        SWL=0        yield=0
        comment=STIFF
    polypro_1in
        category=rope
        type=linear        mass=0.2722        wet=-0.3405       diam=0.0254     length=0
        Cdn=1.5         Cdt=0.005           amn=0           amt=0       EA=60060        EI=0.01         GJ=0.01
        SWL=0   yield=0
    colmega_1in /* effectivly polypro_1in */
        type=linear        diam=0.0254        wet=-0.3054        mass=0.29        length=0
        Cdn=1.5        Cdt=0.005        EA=60060        EI=1.0/10        GJ=0.01
        SWL=0        yield=0
        comment=STIFFENED
    nylon_7/8in
        type=linear        diam=0.02222        wet=0.2846        mass=0.29        length=0
        Cdn=1.5        Cdt=0.005        EA=84071        EI=1.0/10        GJ=0.01
        SWL=0        yield=0
        comment="STIFFENED 01"
    nystron_1in
        type=linear        diam=0.0254        wet=0.7957        mass=0.47        length=0
        Cdn=1.5        Cdt=0.005        EA=748784           EI=1.0/10        GJ=0.01
        SWL=0        yield=0
    nystron_7/8in
        type=linear        diam=0.02222        wet=0.597        mass=0.3526        length=0
        Cdn=1.5        Cdt=0.005        EA=570855        EI=1.0/10        GJ=0.01
           SWL=0        yield=0
    ftorqbal_3/8in
        type=linear        diam=0.009525        wet=2.7901        mass=0.3273        length=0
        Cdn=1.5        Cdt=0.005        EA=4.944e+06        EI=0.1        GJ=1
        SWL=0        yield=0
    ftorqbal_7/16in
        type=linear        diam=0.01099        wet=3.8554        mass=0.4522        length=0
        Cdn=1.5        Cdt=0.005        EA=6.577e+06        EI=0.1        GJ=1
        SWL=0        yield=0
    torqbal_3/8in
        type=linear        diam=0.009525        wet=2.7901        mass=0.3273        length=0
        Cdn=1.5        Cdt=0.005        EA=4.944e+06        EI=1        GJ=1
        SWL=0        yield=0
    torqbal_7/16in
        type=linear        diam=0.01099        wet=3.8554        mass=0.4522        length=0
        Cdn=1.5        Cdt=0.005        EA=6.577e+06        EI=1        GJ=1
        SWL=0        yield=0
    SOFScageWHOIorig
        type=linear    diam=0.6      wet=350     mass=134  length=1.85
        Cdn=1          Cdt=0.1       EA=1e+06    EI=82900  GJ=10000
        SWL=0 yield=0
    SOFScage
        type=linear        diam=0.2           wet=225.0        mass=30        length=1.0
        Cdn=1        Cdt=0.1        EA=1e+06        EI=82900        GJ=10000
        SWL=0        yield=0
        comment="mass 12.4(RCM)+18(cage)=30kg/1.85=16.3 kg/m 7.2+15.7=23kg=225/1.85=122 N/m, was 135, 350"
    SOFSawcp
        type=linear        diam=0.2           wet=350        mass=54        length=1.85
        Cdn=1        Cdt=0.1        EA=1e+06        EI=82900        GJ=10000
        SWL=0        yield=0
        comment="mass 100kg = 54/m kg, wet 650N = 350 N/m"
    SOFSadcp
        type=linear        diam=1.0           wet=524        mass=74        length=1.85
        Cdn=1        Cdt=0.1        EA=1e+06        EI=82900        GJ=10000
        SWL=0        yield=0
        comment="mass 137kg = 74/m kg, wet 970N = 524 N/m"
    chain_3/4in
        type=linear        diam=0.0681        wet=73.7084        mass=8.643        length=0
        Cdn=0.55        Cdt=0.05        EA=1.3e+08           EI=1.0        GJ=0.0001
        SWL=0        yield=0
        comment="crosby pc"
    chain_7/8in
        type=linear        diam=0.0795        wet=85.9931        mass=10.08        length=0
        Cdn=0.55        Cdt=0.05        EA=1.3e+08           EI=1.0        GJ=0.0001
        SWL=0        yield=0
        comment="crosby pc"
    trawler_1/2in
        type=linear        diam=0.0475        wet=31.64        mass=3.712        length=0
        Cdn=0.55        Cdt=0.05        EA=6e+07           EI=1.0        GJ=0.0001
        SWL=0        yield=0
        comment="trawlex acco"
    term_A
        type=linear        diam=0.1079        wet=168.4        mass=19.73        length=0.33
        Cdn=0.55        Cdt=0.05        EA=1.3e+08           EI=1.0        GJ=0.0001
        SWL=0        yield=0
    term_AB
        type=linear        diam=0.1079        wet=141        mass=16.52        length=0.32
        Cdn=0.55        Cdt=0.05        EA=1.3e+08           EI=1.0        GJ=0.0001
        SWL=0        yield=0
    term_B
        type=linear        diam=0.0953        wet=132.8        mass=15.56        length=0.3
        Cdn=0.55        Cdt=0.05        EA=1.3e+08           EI=1.0        GJ=0.0001
        SWL=0        yield=0
    term_C
        type=linear        diam=0.0953        wet=107.45        mass=12.59        length=0.275
        Cdn=0.55        Cdt=0.05        EA=1.3e+08           EI=1.0        GJ=0.0001
        SWL=0        yield=0
        comment="3/4 ch shc - 7/8link - 3/4ch sh"
    term_splice
        type=linear        diam=0.0254        wet=-0.0208        mass=0.58        length=0.5
        Cdn=1.5        Cdt=0.005        EA=748784           EI=1.0        GJ=0.0001
        SWL=0        yield=0
    term_trans
        type=linear        diam=0.1        wet=1.6935        mass=0.3395        length=0.275
        Cdn=0.55        Cdt=0.05        EA=2757427           EI=1.0        GJ=0.0001
        SWL=0        yield=0
        comment="1/2 torque_bal 3/8 and 1/2 nystron"
    term_D
        type=linear        diam=0.0889        wet=134.6        mass=15.77        length=0.145
        Cdn=0.55        Cdt=0.05        EA=1.3e+08           EI=1.0        GJ=0.0001
        SWL=0        yield=0
    term_e
        type=linear        diam=0.11        wet=127.69        mass=15.37        length=0.28
        Cdn=0.55        Cdt=0.05        EA=1.3e+08           EI=1.0        GJ=1000
        SWL=0        yield=0
        comment="3/4 anc sh - 7/8link - 3/4sh"
    term_F
        type=linear        diam=0.0953        wet=123.8        mass=14.5        length=0.29
        Cdn=0.55        Cdt=0.05        EA=1.3e+08           EI=1.0        GJ=0.0001
        SWL=0        yield=0


