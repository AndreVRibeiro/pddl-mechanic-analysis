(define (problem problem_e7) (:domain dungeons-of-dreadrock)
(:objects
    ;; Fireball, walls and trigger
    t1 t2 t3 t4 - tile 
    t5 t6 t7 t8 - tile
    t9 t10 t11 t12 - tile 
    t13 t14 t15 t16 - tile
    p - player
    f1 - fireball

    z0 - zombie
    s0 - sword
    k0 - key
    kh0 - keyhole
    d0 - door
    po0 - portal
)

(:init  (player-alive)
        (player-at p t13)

        (wall t3)
        (wall t10)
        (wall t14)

        (fireball-at f1 t15)
        (enemy-interaction t15)
        (not (fireball-active f1))
        (fireball-origin f1 t15)
        (fireball-path f1 t15 t11)
        (fireball-path f1 t11 t7)
        (fireball-path f1 t7 t3)
        (fireball-trigger f1 t9)
        (interactions t9)

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