(define (problem problem_m1) (:domain dungeons-of-dreadrock)
(:objects
        ;; Empty Level
        t1 t2 t3 t4 t5 t6 - tile 
        t7 t8 t9 t10 t11 t12 - tile
        t13 t14 t15 t16 t17 t18 - tile 
        t19 t20 t21 t22 t23 t24 - tile
        t25 t26 t27 t28 t29 t30 - tile
        t31 t32 t33 t34 t35 t36 - tile
        p - player
        z0 - zombie
        f0 - fireball
        s0 - sword
        k0 - key
        kh0 - keyhole
        d0 - door
        po0 - portal

)

(:init  (player-alive)
        (player-at p t31)

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
             (player-at p t6)
        )
)

)