Problem description
    title = "SOFS 7 Simulation current=CF wave-height=SWH wind=WIND"
    type = surface

Analysis Parameters
    static-relaxation = 0.1
    static-iterations = 5000
    static-tolerance  = 0.001

    relax-adapt-up    = 1.02
    relax-adapt-down  = 1.1

    static-outer-iterations = 1000

    static-outer-relaxation = 0.98
    static-outer-tolerance  = 0.01

    duration           = 200.0
    ramp-time          = 10.0
    time-step          = 0.1
    dynamic-relaxation = 1.0
    dynamic-iterations = 15
    dynamic-tolerance  = 1e-6
    dynamic-rho        = -0.5

Environment
    rho              = 1027
    gravity          = 9.81
    depth            = 4550
    bottom-stiffness = 0
    bottom-damping   = 0
    x-current = {"sofs_des"} (0.00, 0.5*CF)(320.00, 0.35*CF)(1000.00, 0.18*CF)(3200.00, 0.06*CF)(4815.00, 0.06*CF) 
    /* x-current = {"sofs4work"} (0.00, 0.50)(420.00, 0.40)(780.00, 0.30)(1150.00, 0.18)(2240.00, 0.15)(4815.00, 0.06) */
    /* x-current = {"STATIC"} (0.00, 0.05)(400.00, 0.04)(4650.00, 0.02) */
    forcing-method = wave-follower
    input-type = random
    x-wave = ( SWH/2 , PERIOD , 1.5708 )
    x-wind = ( WIND )

Layout
    terminal = {       anchor = clump    safety = 2.00       mu = 1.00       x = 0       y = 0       z = 0    }
    segment = {        length = 5        material = trawler_1/2in        nodes = (6, 1)    }
    connector = pivot
    segment = {        length = 0.28     material = term_e        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 20       material = nystron_1in        nodes = (21, 1)    }
    connector = pivot
    segment = {        length = 0.28     material = term_e        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 5        material = trawler_1/2in        nodes = (6, 1)    }
    connector = pivot
    segment = {        length = 0.28     material = term_e        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 1.94     material = release_dual        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 0.28     material = term_e        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 5        material = trawler_1/2in        nodes = (6, 1)    }
    connector = pivot
    segment = {        length = 0.28     material = term_e        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 52       material = balls_1/2in        nodes = (41, 1)    }
    connector = pivot
    segment = {        length = 0.29     material = term_F        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 1725     material = colmega_1in        nodes = (300, 1)    }
    connector = pivot
    segment = {        length = 0.5     material = term_splice        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 2200     material = nylon_7/8in        nodes = (501, 1)    } 
    connector = pivot
    segment = {        length = 0.275    material = term_C        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 100       material = nylon_7/8in        nodes = (100, 1)    }
    connector = pivot
    segment = {        length = 100       material = nystron_7/8in        nodes = (100, 1)    }
    connector = pivot
    segment = {        length = 0.145    material = term_trans        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 100      material = torqbal_3/8in        nodes = (100, 1)    }
    connector = pivot
/* 1700 m */	
    segment = {        length = 0.275     material = term_C        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 350      material = torqbal_3/8in        nodes = (300, 1)    } 
    connector = pivot
    segment = {        length = 0.275    material = term_C        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 350      material = torqbal_3/8in        nodes = (300, 1)    }
    connector = pivot
/* 1000 m */	
    segment = {        length = 0.275    material = term_C        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 200      material = torqbal_3/8in        nodes = (200, 1)    }
    connector = pivot
    segment = {        length = 0.275    material = term_C        nodes = (3, 1)    }
    connector = pivot
/* 800m */
    segment = {        length = 300      material = torqbal_7/16in        nodes = (300, 1)    }
    connector = pivot
    segment = {        length = 0.3      material = term_B        nodes = (10, 1)    }
    connector = pivot
/* 500m */
/*
    segment = {        length = 1.85     material = SOFSadcp        nodes = (10, 1)    }
    connector = pivot
    segment = {        length = 0.3      material = term_B        nodes = (10, 1)    }
    connector = pivot
*/
    segment = {        length = 300      material = torqbal_7/16in        nodes = (300, 1)    }
    connector = pivot
    segment = {        length = 0.3      material = term_B        nodes = (10, 1)    }
    connector = pivot
/* 200 m */	
/*           
    segment = {        length = 1.0     material = SOFScage        nodes = (10, 1)    }
    connector = pivot
    segment = {        length = 0.3      material = term_B        nodes = (10, 1)    }
    connector = pivot
*/
    segment = {        length = 149      material = torqbal_7/16in  nodes = (150, 1) attachments = sbe37 : (16 3) }
    connector = pivot
    segment = {        length = 0.32     material = term_AB        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 19.5     material = torqbal_7/16in        nodes = (18, 1)    }
    connector = pivot
    segment = {        length = 0.32     material = term_AB        nodes = (3, 1)    }
    connector = pivot
/* 30m */
/*           
    segment = {        length = 1.0        material = chain_7/8in        nodes = (6, 1)    }
    connector = pivot
    segment = {        length = 0.32     material = term_AB        nodes = (3, 1)    }
    connector = pivot
*/
    segment = {        length = 1.0     material = SOFSbgc        nodes = (10, 1)    }
    connector = pivot
/*           
    segment = {        length = 1.0        material = chain_7/8in        nodes = (6, 1)    }
    connector = pivot
*/
    segment = {        length = 0.32     material = term_AB        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 19.5     material = torqbal_7/16in  nodes = (23, 1) attachments = sbe37 : (13 3) }
    connector = pivot
    segment = {        length = 0.32     material = term_AB        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 8        material = chain_7/8in        nodes = (6, 1)    }
    connector = pivot
    segment = {        length = 0.33     material = term_A        nodes = (3, 1)    }
    connector = pivot
    terminal = {       buoy = discus_2.7m       x = 0       y = 0       z = 0    }

Buoys
    discus_2.7m
        type=axisymmetric
/*        mass=2045.45  */
        mass=2300
		diam=2.7 height=3.0 Cdt=1 Cdn=1
        buoyancy=0
        Cdw=1.5
        Sw=6
        diameters=(0.00, 1.00) (0.25, 1.70) (0.75, 2.74) (1.60, 2.74) 

Anchors
    clump
      mass=4500 wet=4000 diam=0 
      Cdt=0 Cdn=0 mu=0

Connectors
    pivot	
        d = 0.01	/* to release moments - use segments mostly */
        m = 0.01
	wet = 0.01
	Cdn = 0.0
	length = 0.0
    sbe37
        mass=4.10909 wet=26.15 diam=0.13716 
        Cdt=0 Cdn=1

Materials
    release_dual
        type=linear        diam=0.15        wet=351        mass=90.9091        length=1.94
        Cdn=1        Cdt=0.05        EA=5e+07           EI=82900        GJ=10000
        SWL=0        yield=0
        comment="EG&G 322 acoustic release - made up in double configuration"
    balls_1/2in
        type=linear        diam=0.1475        wet=-217.5        mass=21.712        length=0
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
    nystron_2in
        type=linear        diam=0.048   wet=1.5914           mass=0.94        length=0
        Cdn=1.5        Cdt=0.005        EA=2632350           EI=1.0/10        GJ=0.01
        SWL=0        yield=0
    nystron_7/8in
        type=linear        diam=0.02222        wet=0.597        mass=0.3526        length=0
        Cdn=1.5        Cdt=0.005        EA=570855        EI=1.0/10        GJ=0.01
           SWL=0        yield=0
    torqbal_9mm
        type=linear        diam=0.009        wet=2.636        mass=0.31        length=0
        Cdn=1.5        Cdt=0.005        EA=4.944e+06        EI=1        GJ=1
        SWL=0        yield=0
    torqbal_3/8in
        type=linear        diam=0.009525        wet=2.7901        mass=0.3273        length=0
        Cdn=1.5        Cdt=0.005        EA=4.944e+06        EI=1        GJ=1
        SWL=0        yield=0
    torqbal_7/16in
        type=linear        diam=0.01099        wet=3.8554        mass=0.4522        length=0
        Cdn=1.5        Cdt=0.005        EA=6.577e+06        EI=1        GJ=1
        SWL=0        yield=0
    dynex_8mm 
        type=linear        diam=0.008        wet=-0.35        mass=0.076        length=0
        Cdn=1.5        Cdt=0.005        EA=5e+05        EI=1        GJ=1
        SWL=0        yield=0
        comment="density = 0.97 g/cm^3, Modulus = 107 GPa"
    SOFScageWHOIorig
        type=linear    diam=0.6      wet=350     mass=134  length=1.85
        Cdn=1          Cdt=0.1       EA=1e+06    EI=82900  GJ=10000
        SWL=0 yield=0
    SOFScage
        type=linear        diam=0.2           wet=225.0        mass=30        length=1.0
        Cdn=1        Cdt=0.1        EA=1e+06        EI=82900        GJ=10000
        SWL=0        yield=0
        comment="mass 12.4(RCM)+18(cage)=30kg/1.85=16.3 kg/m 7.2+15.7=23kg=225/1.85=122 N/m, was 135, 350"
    SOFSbgc
        type=linear        diam=0.2           wet=225.0        mass=30        length=1.0
        Cdn=1.0        Cdt=0.1        EA=1e+06        EI=82900        GJ=10000
        SWL=0        yield=0
        comment="SOFS BGC package SBE37, GTD, FLNTUS, PAR"
    SOFScageHD
        type=linear        diam=0.2           wet=225.0        mass=30        length=1.0
        Cdn=1        Cdt=1.4        EA=1e+06        EI=82900        GJ=10000
        SWL=0        yield=0
        comment="mass 12.4(RCM)+18(cage)=30kg/1.85=16.3 kg/m 7.2+15.7=23kg=225/1.85=122 N/m, was 135, 350"
    SOFSawcp
        type=linear        diam=0.6           wet=450        mass=74        length=1.85
        Cdn=1        Cdt=0.1        EA=1e+06        EI=82900        GJ=10000
        SWL=0        yield=0
        comment="mass 100kg = 54/m kg, wet 650N = 350 N/m"
    SOFSadcp
        type=linear        diam=1.0           wet=524        mass=74        length=1.85
        Cdn=0.8        Cdt=0.1        EA=1e+06        EI=82900        GJ=10000
        SWL=0        yield=0
        comment="mass 137kg = 74/m kg, wet 970N = 524 N/m"
    SOFSras
        type=linear        diam=1.0           wet=1170        mass=173        length=1.85
        Cdn=1        Cdt=0.1        EA=1e+06        EI=82900        GJ=10000
        SWL=0        yield=0
        comment="mass 320kg = 173/m kg, wet 2150N = 1170 N/m"
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
    seacat      
        EA = 5.0e7  EI = 1000.0 GJ = 1000.0   m = 5.5   wet = 3
        d = 0.1   Cdt = 0.7  Cdn = 1.0 Cmt = 1.09    Cmn = 2.0


		
End
