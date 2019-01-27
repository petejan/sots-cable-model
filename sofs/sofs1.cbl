Problem description
    title = "SOFS 1 Simulation"
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
    depth            = 4400
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
    segment = {        length = 50       material = balls_1/2in        nodes = (41, 1)    }
    connector = pivot
    segment = {        length = 0.29     material = term_F        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 1725     material = colmega_1in        nodes = (300, 1)    }
    connector = pivot
    segment = {        length = 0.5     material = term_splice        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 2000     material = nylon_7/8in        nodes = (501, 1)    } /* was 2200 m */
    connector = pivot
    segment = {        length = 0.275    material = term_C        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 90       material = nystron_7/8in        nodes = (100, 1)    }
    connector = pivot
    segment = {        length = 0.145    material = term_trans        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 100      material = torqbal_3/8in        nodes = (100, 1)    }
    connector = pivot
    segment = {        length = 0.275     material = term_C        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 350      material = torqbal_3/8in        nodes = (300, 1)    } 
    connector = pivot
    segment = {        length = 0.275    material = term_C        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 350      material = torqbal_3/8in        nodes = (300, 1)    }
    connector = pivot
    segment = {        length = 0.275    material = term_C        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 200      material = torqbal_3/8in        nodes = (200, 1)    }
    connector = pivot
    segment = {        length = 0.275    material = term_C        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 300      material = torqbal_7/16in        nodes = (300, 1)    }
    connector = pivot
    segment = {        length = 0.3      material = term_B        nodes = (10, 1)    }
    connector = pivot
    segment = {        length = 300      material = torqbal_7/16in        nodes = (300, 1)    }
    connector = pivot
    segment = {        length = 0.3      material = term_B        nodes = (10, 1)    }
    connector = pivot
    segment = {        length = 1.0     material = SOFScage        nodes = (10, 1)    }
    connector = pivot
    segment = {        length = 0.3      material = term_B        nodes = (10, 1)    }
    connector = pivot
    segment = {        length = 149      material = torqbal_7/16in  nodes = (150, 1) attachments = sbe37 : (16 3) }
    connector = pivot
    segment = {        length = 0.32     material = term_AB        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 19.5     material = torqbal_7/16in        nodes = (18, 1)    }
    connector = pivot
    segment = {        length = 0.32     material = term_AB        nodes = (3, 1)    }
    connector = pivot
    segment = {        length = 1.0     material = SOFScage        nodes = (10, 1)    }
    connector = pivot
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
        mass=2045.45 diam=2.7 height=3.0 Cdt=1 Cdn=1
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

#include "materials.cbl"

End
