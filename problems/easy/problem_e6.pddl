
(define (problem problem_e6) (:domain dungeons-of-dreadrock)
(:objects 
    ;; Key, Keyhole, Gate and Walls
    t1 t2 t3 t4 - tile 
    t5 t6 t7 t8 - tile
    t9 t10 t11 t12 - tile 
    t13 t14 t15 t16 - tile
    p - player
    k1 - key
    kh1 - keyhole
    d1 - door

    z0 - zombie
    f0 - fireball
    s0 - sword
    po0 - portal

)

(:init  (player-alive)
        (player-at p t13)

        (wall t3)
        (wall t7)

        (blocked t8)
        (blocked t2)

        (metal-door-at d1 t8)
        (door-closed d1)

        (key-at k1 t1)
        (interactions t1)

        (keyhole-at kh1 t2)
        (opens k1 kh1 d1)
        (not (key-inserted k1 kh1))

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