Problem description
    title = "first run at sofs 1.35 scope"
    type = surface

Analysis parameters
    static-relaxation = 0.1
    static-iterations = 5000
    static-tolerance = 0.001
    static-outer-relaxation = 0.980
    static-outer-iterations = 1000
    static-outer-tolerance = 0.01
    dynamic-relaxation = 1.000
    dynamic-iterations = 15
    dynamic-tolerance = 1e-06
    time-step = 1.0000
    duration = 100
    ramp-time = 10
    static-initial-guess = shooting
    static-solution = relaxation

Environment
    depth = 4650
    density = 1025.0
    gravity = 9.81
    x-current = {"STATIC"} (0.00, 0.05)(400.00, 0.04)(4650.00, 0.02)
    x-wind = 0
    forcing-method = wave-follower
    input-type = random
    x-wave = (0.50, 14.00, 0)

Layout
    terminal = {
       anchor = clump
    safety = 2.00
    mu = 1.00
       x = 0
       y = 0
       z = 0
    }
    segment = {
        length = 5
        material = trawler_1/2in
        nodes = (6, 1)
    }
    connector = pinned
    segment = {
        length = 0.28
        material = term_e
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 20
        material = nystron_1in
        nodes = (21, 1)
    }
    connector = pinned
    segment = {
        length = 0.28
        material = term_e
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 5
        material = trawler_1/2in
        nodes = (6, 1)
    }
    connector = pinned
    segment = {
        length = 0.28
        material = term_e
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 1.94
        material = release_dual
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 0.28
        material = term_e
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 5
        material = trawler_1/2in
        nodes = (6, 1)
    }
    connector = pinned
    segment = {
        length = 0.28
        material = term_e
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 50
        material = balls_1/2in
        nodes = (41, 1)
    }
    connector = pinned
    segment = {
        length = 0.29
        material = term_F
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 1725
        material = colmega_1in
        nodes = (171, 1)
    }
    connector = pinned
    segment = {
        length = 2200
        material = nylon_7/8in
        nodes = (201, 1)
    }
    connector = pinned
    segment = {
        length = 0.275
        material = term_C
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 90
        material = nystron_7/8in
        nodes = (100, 1)
    }
    connector = pinned
    segment = {
        length = 0.145
        material = term_D
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 100
        material = torqbal_3/8in
        nodes = (100, 1)
    }
    connector = pinned
    segment = {
        length = 0.28
        material = term_c
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 350
        material = torqbal_3/8in
        nodes = (100, 1)
    }
    connector = pinned
    segment = {
        length = 0.275
        material = term_C
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 350
        material = torqbal_3/8in
        nodes = (100, 1)
    }
    connector = pinned
    segment = {
        length = 0.275
        material = term_C
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 200
        material = torqbal_3/8in
        nodes = (51, 1)
    }
    connector = pinned
    segment = {
        length = 0.275
        material = term_C
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 300
        material = torqbal_7/16in
        nodes = (51, 1)
    }
    connector = pinned
    segment = {
        length = 0.3
        material = term_B
        nodes = (10, 1)
    }
    connector = pinned
    segment = {
        length = 1.85
        material = "SOFS cage"
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 0.3
        material = term_B
        nodes = (10, 1)
    }
    connector = pinned
    segment = {
        length = 300
        material = torqbal_7/16in
        nodes = (51, 1)
    }
    connector = pinned
    segment = {
        length = 0.3
        material = term_B
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 149
        material = torqbal_7/16in
        nodes = (18, 1)
        attachments = sbe37 : (16 3 )
    }
    connector = pinned
    segment = {
        length = 0.32
        material = term_AB
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 19.5
        material = torqbal_7/16in
        nodes = (18, 1)
    }
    connector = pinned
    segment = {
        length = 0.32
        material = term_AB
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 1.85
        material = "SOFS cage"
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 0.32
        material = term_AB
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 19.5
        material = torqbal_7/16in
        nodes = (23, 1)
        attachments = sbe37 : (13 3 )
    }
    connector = pinned
    segment = {
        length = 0.32
        material = term_AB
        nodes = (3, 1)
    }
    connector = pinned
    segment = {
        length = 8
        material = chain_3/4in
        nodes = (6, 1)
    }
    connector = pinned
    segment = {
        length = 0.33
        material = term_A
        nodes = (3, 1)
    }
    connector = pinned
    terminal = {
       buoy = discus_2.7m
       x = 0
       y = 0
       z = 0
    }

Buoys
    discus_2.7m
        type=axisymmetric
        mass=2045.45
        diam=0
        height=0
        Cdt=1
        Cdn=1
        buoyancy=0
        Cdw=1.5
        Sw=6
        diameters=(0.00, 1.00) (0.25, 1.70) (0.75, 2.74) (1.60, 2.74) 

Anchors
    clump
        mass=0
        wet=0
        diam=0
        Cdt=0
        Cdn=0
        mu=0

Connectors
    sbe37
        mass=4.10909
        wet=26.15
        diam=0.13716
        Cdt=0
        Cdn=1

Materials
    trawler_1/2in
        type=linear
        diam=0.0475
        wet=31.64
        mass=3.712
        length=0
        Cdn=0.55
        Cdt=0.05
        EA=6e+07
        EI=0.0001
        GJ=0.0001
        SWL=0
        yield=0
        comment="trawlex acco"
    term_e
        type=linear
        diam=0.11
        wet=127.69
        mass=15.37
        length=0.28
        Cdn=0.55
        Cdt=0.05
        EA=1.3e+08
        EI=1000
        GJ=1000
        SWL=0
        yield=0
        comment="3/4 anc sh - 7/8link - 3/4sh"
    nystron_1in
        type=linear
        diam=0.0254
        wet=0.7957
        mass=0.47
        length=0
        Cdn=1.5
        Cdt=0.005
        EA=748784
        EI=0.01
        GJ=0.01
        SWL=0
        yield=0
    release_dual
        type=linear
        diam=0.15
        wet=351
        mass=90.9091
        length=1.94
        Cdn=1
        Cdt=0.05
        EA=5e+07
        EI=10000
        GJ=10000
        SWL=0
        yield=0
        comment="EG&G 322 acoustic release - made up"
    balls_1/2in
        type=linear
        diam=0.0475
        wet=-217.5
        mass=21.712
        length=0
        Cdn=2.6
        Cdt=0.7
        EA=6e+07
        EI=0.01
        GJ=0.0001
        SWL=0
        yield=0
        comment=STIFF
    term_F
        type=linear
        diam=0.0953
        wet=123.8
        mass=14.5
        length=0.29
        Cdn=0.55
        Cdt=0.05
        EA=1.3e+08
        EI=0.0001
        GJ=0.0001
        SWL=0
        yield=0
    colmega_1in
        type=linear
        diam=0.0254
        wet=-0.3054
        mass=0.29
        length=0
        Cdn=1.5
        Cdt=0.005
        EA=60060
        EI=0.01
        GJ=0.01
        SWL=0
        yield=0
        comment=STIFFENED
    nylon_7/8in
        type=linear
        diam=0.02222
        wet=0.2846
        mass=0.29
        length=0
        Cdn=1.5
        Cdt=0.005
        EA=84071
        EI=0.01
        GJ=0.01
        SWL=0
        yield=0
        comment="STIFFENED 01"
    term_C
        type=linear
        diam=0.0953
        wet=107.45
        mass=12.59
        length=0.275
        Cdn=0.55
        Cdt=0.05
        EA=1.3e+08
        EI=0.0001
        GJ=0.0001
        SWL=0
        yield=0
    nystron_7/8in
        type=linear
        diam=0.02222
        wet=0.597
        mass=0.3526
        length=0
        Cdn=1.5
        Cdt=0.005
        EA=570855
        EI=0.01
        GJ=0.01
        SWL=0
        yield=0
    term_D
        type=linear
        diam=0.0889
        wet=134.6
        mass=15.77
        length=0.145
        Cdn=0.55
        Cdt=0.05
        EA=1.3e+08
        EI=0.0001
        GJ=0.0001
        SWL=0
        yield=0
    torqbal_3/8in
        type=linear
        diam=0.009525
        wet=2.7901
        mass=0.3273
        length=0
        Cdn=1.5
        Cdt=0.005
        EA=4.944e+06
        EI=1
        GJ=1
        SWL=0
        yield=0
    term_c
        type=linear
        diam=0.097
        wet=97.6
        mass=11.76
        length=0.28
        Cdn=0.55
        Cdt=0.05
        EA=1.3e+08
        EI=1000
        GJ=1000
        SWL=0
        yield=0
        comment="3/4 ch shc - 7/8link - 3/4ch sh"
    torqbal_7/16in
        type=linear
        diam=0.01099
        wet=3.8554
        mass=0.4522
        length=0
        Cdn=1.5
        Cdt=0.005
        EA=6.577e+06
        EI=1
        GJ=1
        SWL=0
        yield=0
    term_B
        type=linear
        diam=0.0953
        wet=132.8
        mass=15.56
        length=0.3
        Cdn=0.55
        Cdt=0.05
        EA=1.3e+08
        EI=0.0001
        GJ=0.0001
        SWL=0
        yield=0
    "SOFS cage"
        type=linear
        diam=0.6
        wet=350
        mass=134
        length=1.85
        Cdn=1
        Cdt=0.1
        EA=1e+06
        EI=82900
        GJ=10000
        SWL=0
        yield=0
    term_AB
        type=linear
        diam=0.1079
        wet=141
        mass=16.52
        length=0.32
        Cdn=0.55
        Cdt=0.05
        EA=1.3e+08
        EI=0.0001
        GJ=0.0001
        SWL=0
        yield=0
    chain_3/4in
        type=linear
        diam=0.0681
        wet=73.7084
        mass=8.643
        length=0
        Cdn=0.55
        Cdt=0.05
        EA=1.3e+08
        EI=0.0001
        GJ=0.0001
        SWL=0
        yield=0
        comment="crosby pc"
    term_A
        type=linear
        diam=0.1079
        wet=168.4
        mass=19.73
        length=0.33
        Cdn=0.55
        Cdt=0.05
        EA=1.3e+08
        EI=0.0001
        GJ=0.0001
        SWL=0
        yield=0


End
