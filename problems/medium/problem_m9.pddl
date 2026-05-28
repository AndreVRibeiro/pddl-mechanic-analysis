(define (problem problem_m9) (:domain dungeons-of-dreadrock)
(:objects
        ;; Zombies, Sword and Walls
        t1 t2 t3 t4 t5 t6 - tile 
        t7 t8 t9 t10 t11 t12 - tile
        t13 t14 t15 t16 t17 t18 - tile 
        t19 t20 t21 t22 t23 t24 - tile
        t25 t26 t27 t28 t29 t30 - tile
        t31 t32 t33 t34 t35 t36 - tile
        p - player
        z1 - zombie
        z2 - zombie
        z3 - zombie
        z4 - zombie
        z5 - zombie
        s1 - sword


        f0 - fireball
        k0 - key
        kh0 - keyhole
        d0 - door
        po0 - portal

)

(:init  (player-alive)
        (player-at p t31)

        (wall t1)
        (wall t4)
        (wall t5)
        (wall t6)
        (wall t7)
        (wall t9)
        (wall t10)
        (wall t12)
        (wall t15)
        (wall t19)
        (wall t21)
        (wall t25)
        (wall t27)

        (sword-at s1 t3)
        (interactions t3)

        (zombie-at z1 t32)
        (enemy-interaction t32)
        (zombie-alive z1)
        (zombie-path-forward z1 t32 t26)
        (zombie-path-forward z1 t26 t20)
        (zombie-path-forward z1 t20 t14)
        (zombie-path-forward z1 t14 t8)
        (zombie-path-forward z1 t8 t2)     
        (zombie-path-backward z1 t2 t8)
        (zombie-path-backward z1 t8 t14)
        (zombie-path-backward z1 t14 t20)
        (zombie-path-backward z1 t20 t26)
        (zombie-path-backward z1 t26 t32)    
        (zombie-path-forward-last z1 t2)    
        (zombie-path-backward-last z1 t32)
        (zombie-forward z1)

        (zombie-at z2 t28)
        (enemy-interaction t28)
        (zombie-alive z2)
        (zombie-path-forward z2 t28 t22)     
        (zombie-path-backward z2 t22 t28)    
        (zombie-path-forward-last z2 t22)    
        (zombie-path-backward-last z2 t28)
        (zombie-forward z2)

        (zombie-at z3 t23)
        (enemy-interaction t23)
        (zombie-alive z3)
        (zombie-path-forward z3 t23 t29)     
        (zombie-path-backward z3 t29 t23)    
        (zombie-path-forward-last z3 t29)    
        (zombie-path-backward-last z3 t23)
        (zombie-forward z3)

        (zombie-at z4 t24)
        (enemy-interaction t24)
        (zombie-alive z4)
        (zombie-path-forward z4 t24 t30)
        (zombie-path-forward z4 t30 t36)     
        (zombie-path-backward z4 t36 t30)
        (zombie-path-backward z4 t30 t24)    
        (zombie-path-forward-last z4 t36)    
        (zombie-path-backward-last z4 t24)
        (zombie-forward z4)

        (zombie-at z5 t35)
        (enemy-interaction t35)
        (zombie-alive z5)
        (zombie-path-forward z5 t35 t34)     
        (zombie-path-backward z5 t34 t35)    
        (zombie-path-forward-last z5 t34)    
        (zombie-path-backward-last z5 t35)
        (zombie-forward z5)

        (adjacent t1 t2)
        (adjacent t1 t7)

        (adjacent t2 t1)
        (adjacent t2 t3)
        (adjacent t2 t8)

        (adjacent t3 t2)
        (adjacent t3 t4)
        (adjacent t3 t9)

        (adjacent t4 t3)
        (adjacent t4 t5)
        (adjacent t4 t10) 

        (adjacent t5 t4)
        (adjacent t5 t6) 
        (adjacent t5 t11)

        (adjacent t6 t5)
        (adjacent t6 t12) 

        (adjacent t7 t8)
        (adjacent t7 t1)
        (adjacent t7 t13) 

        (adjacent t8 t7)
        (adjacent t8 t9) 
        (adjacent t8 t2)
        (adjacent t8 t14)

        (adjacent t9 t8)
        (adjacent t9 t10) 
        (adjacent t9 t3)
        (adjacent t9 t15) 

        (adjacent t10 t9)
        (adjacent t10 t11) 
        (adjacent t10 t4)
        (adjacent t10 t16) 

        (adjacent t11 t10)
        (adjacent t11 t12) 
        (adjacent t11 t5)
        (adjacent t11 t17) 

        (adjacent t12 t11)
        (adjacent t12 t6)
        (adjacent t12 t18) 

        (adjacent t13 t14)
        (adjacent t13 t7)
        (adjacent t13 t19) 

        (adjacent t14 t13)
        (adjacent t14 t15)
        (adjacent t14 t8)
        (adjacent t14 t20)

        (adjacent t15 t14)
        (adjacent t15 t16)
        (adjacent t15 t9)
        (adjacent t15 t21) 

        (adjacent t16 t15)
        (adjacent t16 t17)
        (adjacent t16 t10)
        (adjacent t16 t22) 

        (adjacent t17 t16)
        (adjacent t17 t18)
        (adjacent t17 t11)
        (adjacent t17 t23) 

        (adjacent t18 t17)
        (adjacent t18 t12)
        (adjacent t18 t24) 

        (adjacent t19 t20)
        (adjacent t19 t13)
        (adjacent t19 t25) 

        (adjacent t20 t19)
        (adjacent t20 t21)
        (adjacent t20 t14)
        (adjacent t20 t26) 

        (adjacent t21 t20)
        (adjacent t21 t22)
        (adjacent t21 t15)
        (adjacent t21 t27) 

        (adjacent t22 t21)
        (adjacent t22 t23)
        (adjacent t22 t16)
        (adjacent t22 t28) 

        (adjacent t23 t22)
        (adjacent t23 t24)
        (adjacent t23 t17)
        (adjacent t23 t29) 

        (adjacent t24 t23)
        (adjacent t24 t18)
        (adjacent t24 t30) 

        (adjacent t25 t26)
        (adjacent t25 t19)
        (adjacent t25 t31) 

        (adjacent t26 t25)
        (adjacent t26 t27)
        (adjacent t26 t20)
        (adjacent t26 t32) 

        (adjacent t27 t26)
        (adjacent t27 t28)
        (adjacent t27 t21)
        (adjacent t27 t33) 

        (adjacent t28 t27)
        (adjacent t28 t29)
        (adjacent t28 t22)
        (adjacent t28 t34) 

        (adjacent t29 t28)
        (adjacent t29 t30)
        (adjacent t29 t23)
        (adjacent t29 t35) 

        (adjacent t30 t29)
        (adjacent t30 t24)
        (adjacent t30 t36) 

        (adjacent t31 t32)
        (adjacent t31 t25)

        (adjacent t32 t31)
        (adjacent t32 t33)
        (adjacent t32 t26)

        (adjacent t33 t32)
        (adjacent t33 t34)
        (adjacent t33 t27)

        (adjacent t34 t33)
        (adjacent t34 t35)
        (adjacent t34 t28)

        (adjacent t35 t34)
        (adjacent t35 t36)
        (adjacent t35 t29)

        (adjacent t36 t35)
        (adjacent t36 t30)

)

(:goal  (and (player-alive)
             (player-at p t11)
        )
)

)