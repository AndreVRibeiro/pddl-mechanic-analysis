(define (problem problem_e5) (:domain dungeons-of-dreadrock)
(:objects
        ;; Zombies
        t1 t2 t3 t4 - tile 
        t5 t6 t7 t8 - tile
        t9 t10 t11 t12 - tile 
        t13 t14 t15 t16 - tile
        p - player
        z1 - zombie

        f0 - fireball
        s0 - sword
        k0 - key
        kh0 - keyhole
        d0 - door
        po0 - portal

)

(:init  (player-alive)
        (player-at p t13)

        (zombie-at z1 t9)
        (enemy-interaction t9)
        (zombie-alive z1)
        (zombie-path-forward z1 t9 t10)
        (zombie-path-forward z1 t10 t11)
        (zombie-path-forward z1 t11 t12)     
        (zombie-path-backward z1 t12 t11)
        (zombie-path-backward z1 t11 t10)
        (zombie-path-backward z1 t10 t9)   
        (zombie-path-forward-last z1 t12)    
        (zombie-path-backward-last z1 t9)
        (zombie-forward z1)

        (adjacent t1 t2)
        (adjacent t1 t5)

        (adjacent t2 t1)
        (adjacent t2 t3)
        (adjacent t2 t6)

        (adjacent t3 t2)
        (adjacent t3 t4)
        (adjacent t3 t7)

        (adjacent t4 t3)
        (adjacent t4 t8)

        (adjacent t5 t1)
        (adjacent t5 t6)
        (adjacent t5 t9)

        (adjacent t6 t2)
        (adjacent t6 t5)
        (adjacent t6 t7)
        (adjacent t6 t10)

        (adjacent t7 t3)
        (adjacent t7 t6)
        (adjacent t7 t8)
        (adjacent t7 t11)

        (adjacent t8 t4)
        (adjacent t8 t7)
        (adjacent t8 t12)

        (adjacent t9 t5)
        (adjacent t9 t10)
        (adjacent t9 t13)

        (adjacent t10 t6)
        (adjacent t10 t9)
        (adjacent t10 t11)
        (adjacent t10 t14)

        (adjacent t11 t7)
        (adjacent t11 t10)
        (adjacent t11 t12)
        (adjacent t11 t15)

        (adjacent t12 t8)
        (adjacent t12 t11)
        (adjacent t12 t16)

        (adjacent t13 t9)
        (adjacent t13 t14)

        (adjacent t14 t10)
        (adjacent t14 t13)
        (adjacent t14 t15)

        (adjacent t15 t11)
        (adjacent t15 t14)
        (adjacent t15 t16)

        (adjacent t16 t12)
        (adjacent t16 t15)
        
)

(:goal  (and (player-alive)
             (player-at p t4)
        )
)

)