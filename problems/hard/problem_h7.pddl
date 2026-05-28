(define (problem problem_h7) (:domain dungeons-of-dreadrock)
(:objects
        ;; Fireball, walls and trigger
        t1 t2 t3 t4 t5 t6 t7 t8 - tile 
        t9 t10 t11 t12 t13 t14 t15 t16 - tile
        t17 t18 t19 t20 t21 t22 t23 t24 - tile 
        t25 t26 t27 t28 t29 t30 t31 t32 - tile
        t33 t34 t35 t36 t37 t38 t39 t40 - tile
        t41 t42 t43 t44 t45 t46 t47 t48 - tile
        t49 t50 t51 t52 t53 t54 t55 t56 - tile
        t57 t58 t59 t60 t61 t62 t63 t64 - tile

        
        p - player
        z0 - zombie
        f1 - fireball
        f2 - fireball
        f3 - fireball
        f4 - fireball
        s0 - sword
        k0 - key
        kh0 - keyhole
        d0 - door
        po0 - portal

)

(:init  (player-alive)
        (player-at p t49)

        (wall t1)
        (wall t2)
        (wall t3)
        (wall t4)
        (wall t5)
        (wall t6)
        (wall t8)
        (wall t9)
        (wall t17)
        (wall t19)
        (wall t20)
        (wall t22)
        (wall t24)
        (wall t25)
        (wall t27)
        (wall t29)
        (wall t30)
        (wall t32)
        (wall t33)
        (wall t35)
        (wall t37)
        (wall t38)
        (wall t40)
        (wall t41)
        (wall t43)
        (wall t45)
        (wall t46)
        (wall t48)
        (wall t51)
        (wall t56)
        (wall t57)
        (wall t59)
        (wall t60)
        (wall t61)
        (wall t63)
        (wall t64)

        (fireball-at f1 t58)
        (enemy-interaction t58)
        (not (fireball-active f1))
        (fireball-origin f1 t58)
        (fireball-path f1 t58 t50)
        (fireball-path f1 t50 t42)
        (fireball-path f1 t42 t34)
        (fireball-path f1 t34 t26)
        (fireball-path f1 t26 t18)
        (fireball-path f1 t18 t10)
        (fireball-path f1 t10 t2)
        (fireball-trigger f1 t50)
        (interactions t50)

        (fireball-at f2 t16)
        (enemy-interaction t16)
        (not (fireball-active f2))
        (fireball-origin f2 t16)
        (fireball-path f2 t16 t15)
        (fireball-path f2 t15 t14)
        (fireball-path f2 t14 t13)
        (fireball-path f2 t13 t12)
        (fireball-path f2 t12 t11)
        (fireball-path f2 t11 t10)
        (fireball-path f2 t10 t9)
        (fireball-trigger f2 t11)
        (interactions t11)

        (fireball-at f3 t7)
        (enemy-interaction t7)
        (not (fireball-active f3))
        (fireball-origin f3 t7)
        (fireball-path f3 t7 t15)
        (fireball-path f3 t15 t23)
        (fireball-path f3 t23 t31)
        (fireball-path f3 t31 t39)
        (fireball-path f3 t39 t47)
        (fireball-path f3 t47 t55)
        (fireball-path f3 t55 t63)
        (fireball-trigger f3 t15)
        (interactions t15)

        (fireball-at f4 t52)
        (enemy-interaction t52)
        (not (fireball-active f4))
        (fireball-origin f4 t52)
        (fireball-path f4 t52 t53)
        (fireball-path f4 t53 t54)
        (fireball-path f4 t54 t55)
        (fireball-path f4 t55 t56)
        (fireball-trigger f4 t55)
        (interactions t55)

        
        (adjacent t1 t2) (adjacent t2 t1)
        (adjacent t2 t3) (adjacent t3 t2)
        (adjacent t3 t4) (adjacent t4 t3)
        (adjacent t4 t5) (adjacent t5 t4)
        (adjacent t5 t6) (adjacent t6 t5)
        (adjacent t6 t7) (adjacent t7 t6)
        (adjacent t7 t8) (adjacent t8 t7)

        (adjacent t9 t10) (adjacent t10 t9)
        (adjacent t10 t11) (adjacent t11 t10)
        (adjacent t11 t12) (adjacent t12 t11)
        (adjacent t12 t13) (adjacent t13 t12)
        (adjacent t13 t14) (adjacent t14 t13)
        (adjacent t14 t15) (adjacent t15 t14)
        (adjacent t15 t16) (adjacent t16 t15)

        (adjacent t17 t18) (adjacent t18 t17)
        (adjacent t18 t19) (adjacent t19 t18)
        (adjacent t19 t20) (adjacent t20 t19)
        (adjacent t20 t21) (adjacent t21 t20)
        (adjacent t21 t22) (adjacent t22 t21)
        (adjacent t22 t23) (adjacent t23 t22)
        (adjacent t23 t24) (adjacent t24 t23)

        (adjacent t25 t26) (adjacent t26 t25)
        (adjacent t26 t27) (adjacent t27 t26)
        (adjacent t27 t28) (adjacent t28 t27)
        (adjacent t28 t29) (adjacent t29 t28)
        (adjacent t29 t30) (adjacent t30 t29)
        (adjacent t30 t31) (adjacent t31 t30)
        (adjacent t31 t32) (adjacent t32 t31)

        (adjacent t33 t34) (adjacent t34 t33)
        (adjacent t34 t35) (adjacent t35 t34)
        (adjacent t35 t36) (adjacent t36 t35)
        (adjacent t36 t37) (adjacent t37 t36)
        (adjacent t37 t38) (adjacent t38 t37)
        (adjacent t38 t39) (adjacent t39 t38)
        (adjacent t39 t40) (adjacent t40 t39)

        (adjacent t41 t42) (adjacent t42 t41)
        (adjacent t42 t43) (adjacent t43 t42)
        (adjacent t43 t44) (adjacent t44 t43)
        (adjacent t44 t45) (adjacent t45 t44)
        (adjacent t45 t46) (adjacent t46 t45)
        (adjacent t46 t47) (adjacent t47 t46)
        (adjacent t47 t48) (adjacent t48 t47)

        (adjacent t49 t50) (adjacent t50 t49)
        (adjacent t50 t51) (adjacent t51 t50)
        (adjacent t51 t52) (adjacent t52 t51)
        (adjacent t52 t53) (adjacent t53 t52)
        (adjacent t53 t54) (adjacent t54 t53)
        (adjacent t54 t55) (adjacent t55 t54)
        (adjacent t55 t56) (adjacent t56 t55)

        (adjacent t57 t58) (adjacent t58 t57)
        (adjacent t58 t59) (adjacent t59 t58)
        (adjacent t59 t60) (adjacent t60 t59)
        (adjacent t60 t61) (adjacent t61 t60)
        (adjacent t61 t62) (adjacent t62 t61)
        (adjacent t62 t63) (adjacent t63 t62)
        (adjacent t63 t64) (adjacent t64 t63)

        (adjacent t1 t9)  (adjacent t9 t1)
        (adjacent t2 t10) (adjacent t10 t2)
        (adjacent t3 t11) (adjacent t11 t3)
        (adjacent t4 t12) (adjacent t12 t4)
        (adjacent t5 t13) (adjacent t13 t5)
        (adjacent t6 t14) (adjacent t14 t6)
        (adjacent t7 t15) (adjacent t15 t7)
        (adjacent t8 t16) (adjacent t16 t8)

        (adjacent t9 t17)  (adjacent t17 t9)
        (adjacent t10 t18) (adjacent t18 t10)
        (adjacent t11 t19) (adjacent t19 t11)
        (adjacent t12 t20) (adjacent t20 t12)
        (adjacent t13 t21) (adjacent t21 t13)
        (adjacent t14 t22) (adjacent t22 t14)
        (adjacent t15 t23) (adjacent t23 t15)
        (adjacent t16 t24) (adjacent t24 t16)

        (adjacent t17 t25) (adjacent t25 t17)
        (adjacent t18 t26) (adjacent t26 t18)
        (adjacent t19 t27) (adjacent t27 t19)
        (adjacent t20 t28) (adjacent t28 t20)
        (adjacent t21 t29) (adjacent t29 t21)
        (adjacent t22 t30) (adjacent t30 t22)
        (adjacent t23 t31) (adjacent t31 t23)
        (adjacent t24 t32) (adjacent t32 t24)

        (adjacent t25 t33) (adjacent t33 t25)
        (adjacent t26 t34) (adjacent t34 t26)
        (adjacent t27 t35) (adjacent t35 t27)
        (adjacent t28 t36) (adjacent t36 t28)
        (adjacent t29 t37) (adjacent t37 t29)
        (adjacent t30 t38) (adjacent t38 t30)
        (adjacent t31 t39) (adjacent t39 t31)
        (adjacent t32 t40) (adjacent t40 t32)

        (adjacent t33 t41) (adjacent t41 t33)
        (adjacent t34 t42) (adjacent t42 t34)
        (adjacent t35 t43) (adjacent t43 t35)
        (adjacent t36 t44) (adjacent t44 t36)
        (adjacent t37 t45) (adjacent t45 t37)
        (adjacent t38 t46) (adjacent t46 t38)
        (adjacent t39 t47) (adjacent t47 t39)
        (adjacent t40 t48) (adjacent t48 t40)

        (adjacent t41 t49) (adjacent t49 t41)
        (adjacent t42 t50) (adjacent t50 t42)
        (adjacent t43 t51) (adjacent t51 t43)
        (adjacent t44 t52) (adjacent t52 t44)
        (adjacent t45 t53) (adjacent t53 t45)
        (adjacent t46 t54) (adjacent t54 t46)
        (adjacent t47 t55) (adjacent t55 t47)
        (adjacent t48 t56) (adjacent t56 t48)

        (adjacent t49 t57) (adjacent t57 t49)
        (adjacent t50 t58) (adjacent t58 t50)
        (adjacent t51 t59) (adjacent t59 t51)
        (adjacent t52 t60) (adjacent t60 t52)
        (adjacent t53 t61) (adjacent t61 t53)
        (adjacent t54 t62) (adjacent t62 t54)
        (adjacent t55 t63) (adjacent t63 t55)
        (adjacent t56 t64) (adjacent t64 t56)

        


)

(:goal  (and (player-alive)
             (player-at p t28)
        )
)

)