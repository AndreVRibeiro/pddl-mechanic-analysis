(define (domain dungeons-of-dreadrock)
    (:requirements :typing :negative-preconditions :conditional-effects :equality :universal-preconditions)

    (:types player tile door key keyhole sword zombie fireball portal)

    (:predicates
        ;; Player
        (player-at ?p - player ?t - tile)
        (player-alive)
        (player-has-sword)
        (player-has-key ?k - key)

        ;; Grid structure
        (adjacent ?from - tile ?to - tile)
        (wall ?t - tile)
        (blocked ?t - tile)
        (interactions ?t - tile)

        ;; Sword
        (sword-at ?s - sword ?t - tile)
    
        
        ;; Keys & Keyholes
        (key-at ?k - key ?t - tile)
        (keyhole-at ?kh - keyhole ?t - tile)
        (opens ?k - key ?kh - keyhole ?d - door)
        (key-inserted ?k - key ?kh - keyhole)

        ;; Doors
        (wooden-door-at ?d - door ?t - tile)
        (metal-door-at ?d - door ?t - tile)
        (door-closed ?d - door)

        ;; Zombies
        (zombie-at ?z - zombie ?t - tile)
        (zombie-alive ?z - zombie)
        (zombie-path-forward ?z - zombie ?from - tile ?to - tile)     
        (zombie-path-backward ?z - zombie ?from - tile ?to - tile)    
        (zombie-path-forward-last ?z - zombie ?t - tile)    
        (zombie-path-backward-last ?z - zombie ?t - tile)
        (zombie-forward ?z - zombie)
        
        (enemy-interaction ?t - tile)

        ;; Fireballs
        (fireball-at ?f - fireball ?t - tile)
        (fireball-active ?f - fireball)
        (fireball-origin ?f - fireball ?t - tile)
        (fireball-path ?f - fireball ?from - tile ?to - tile)
        (fireball-trigger ?f - fireball ?t - tile)
        
        

        ;; Portals
        (portal-at ?p - portal ?from - tile)
        (portal-exit ?p - portal ?to - tile)
        
    )

    (:action move
        :parameters     (?p - player ?from - tile ?to - tile )
        :precondition   (and (player-alive)
                             (player-at ?p ?from)
                             (adjacent ?from ?to)
                             (not (wall ?to))
                             (not (blocked ?to))
                             (not (interactions ?from))
                             (not (enemy-interaction ?from))
                             (not (enemy-interaction ?to))
                        )
        :effect         (and
                            ;; Move player
                            (not (player-at ?p ?from))
                            (player-at ?p ?to)

                            ;; Fireball movement
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile)
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (not (wall ?fbto)))
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (fireball-at ?fb ?fbto) (enemy-interaction ?fbto))))
                            
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile) 
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (wall ?fbto)) 
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (not (fireball-active ?fb)))))

                            ;; Zombie movement (back-and-forth)
                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (zombie-path-forward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (not (zombie-forward ?z)))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (not (zombie-path-forward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (zombie-path-backward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (zombie-forward ?z))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (not (zombie-path-backward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))
                        )
    )

    (:action collect-sword
        :parameters (?p - player ?pt - tile  ?s - sword )
        :precondition   (and (player-alive)
                             (player-at ?p ?pt)
                             (sword-at ?s ?pt)
                             

                             
                        )
        :effect         (and 
                            (player-has-sword) 
                            (not (sword-at ?s ?pt))
                            (not (interactions ?pt))
                            

                            ;; Fireball movement
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile)
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (not (wall ?fbto)))
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (fireball-at ?fb ?fbto) (enemy-interaction ?fbto))))
                            
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile) 
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (wall ?fbto)) 
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (not (fireball-active ?fb)))))

                            ;; Zombie movement (back-and-forth)
                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (zombie-path-forward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (not (zombie-forward ?z)))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (not (zombie-path-forward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (zombie-path-backward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (zombie-forward ?z))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (not (zombie-path-backward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))
                        )
    )

    (:action collect-key
        :parameters (?p - player ?pt - tile ?k - key )
        :precondition   (and (player-alive)
                             (player-at ?p ?pt)
                             (key-at ?k ?pt)
                             
                             
                        )
        :effect         (and 
                            
                            (player-has-key ?k) 
                            (not (key-at ?k ?pt))
                            (not (interactions ?pt))

                            ;; Fireball movement
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile)
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (not (wall ?fbto)))
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (fireball-at ?fb ?fbto) (enemy-interaction ?fbto))))
                            
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile) 
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (wall ?fbto)) 
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (not (fireball-active ?fb)))))

                            ;; Zombie movement (back-and-forth)
                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (zombie-path-forward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (not (zombie-forward ?z)))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (not (zombie-path-forward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (zombie-path-backward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (zombie-forward ?z))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (not (zombie-path-backward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))
                        )
    )

    (:action teleport
        :parameters (?p - player ?pt - tile ?po - portal ?pexit - tile )
        :precondition   (and (player-alive)
                             (player-at ?p ?pt)
                             
                             (portal-at ?po ?pt)
                             (portal-exit ?po ?pexit)
                        )
        :effect         (and 
                            (not (player-at ?p ?pt))
                            (player-at ?p ?pexit)


                            ;; Fireball movement
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile)
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (not (wall ?fbto)))
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (fireball-at ?fb ?fbto) (enemy-interaction ?fbto))))
                            
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile) 
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (wall ?fbto)) 
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (not (fireball-active ?fb)))))

                            ;; Zombie movement (back-and-forth)
                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (zombie-path-forward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (not (zombie-forward ?z)))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (not (zombie-path-forward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (zombie-path-backward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (zombie-forward ?z))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (not (zombie-path-backward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))
                        )
    )

    (:action activate-fireball
        :parameters (?p - player ?pt - tile ?to - tile ?f - fireball ?fstart - tile  )
        :precondition   (and (player-alive)
                             (player-at ?p ?pt)
                             
                             (fireball-trigger ?f ?pt)
                             (fireball-origin ?f ?fstart)
                             (not (fireball-active ?f))
                             
                        )
        :effect         (and 
                            
                            (fireball-active ?f) 
                            (fireball-at ?f ?fstart)
                            (not (interactions ?pt))
                            (enemy-interaction ?fstart)


                            ;; Fireball movement
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile)
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (not (wall ?fbto)))
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (fireball-at ?fb ?fbto) (enemy-interaction ?fbto))))
                            
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile) 
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (wall ?fbto)) 
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (not (fireball-active ?fb)))))

                            ;; Zombie movement (back-and-forth)
                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (zombie-path-forward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (not (zombie-forward ?z)))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (not (zombie-path-forward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (zombie-path-backward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (zombie-forward ?z))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (not (zombie-path-backward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))
                        )
    )
    
    (:action defense-zombie
        :parameters (?p - player ?position - tile ?z - zombie)
        :precondition   (and (player-alive)
                             (player-at ?p ?position)
                             (player-has-sword)
                             (zombie-at ?z ?position)
                             
                             (zombie-alive ?z))
        :effect         (and 
                            
                            (not (zombie-at ?z ?position))
                            (not (enemy-interaction ?position))
                            (not (zombie-alive ?z))

                            ;; Fireball movement
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile)
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (not (wall ?fbto)))
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (fireball-at ?fb ?fbto) (enemy-interaction ?fbto))))
                            
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile) 
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (wall ?fbto)) 
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (not (fireball-active ?fb)))))

                            ;; Zombie movement (back-and-forth)
                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (not (zombie-at ?zb ?fromz)) (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (zombie-path-forward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (not (zombie-forward ?z)))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (not (zombie-at ?zb ?fromz)) (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (not (zombie-path-forward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (not (zombie-at ?zb ?fromz)) (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (zombie-path-backward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (zombie-forward ?z))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (not (zombie-at ?zb ?fromz)) (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (not (zombie-path-backward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))
                        )
    )

    (:action attack-zombie
        :parameters (?p - player ?from - tile ?to - tile ?zb - zombie)
        :precondition   (and (player-alive)
                             (player-at ?p ?from)
                             (adjacent ?from ?to)
                             (player-has-sword)
                             (zombie-at ?zb ?to)
                             (not (enemy-interaction ?from))
                             (zombie-alive ?zb))
        :effect         (and 
                            (player-at ?p ?to)
                            (not (player-at ?p ?from))
                            (not (zombie-at ?zb ?to))
                            (not (enemy-interaction ?to))
                            (not (zombie-alive ?zb))
                            

                            ;; Fireball movement
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile)
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (not (wall ?fbto)))
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (fireball-at ?fb ?fbto) (enemy-interaction ?fbto))))
                            
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile) 
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (wall ?fbto)) 
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (not (fireball-active ?fb)))))

                            ;; Zombie movement (back-and-forth)
                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (not (zombie-at ?zb ?fromz)) (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (zombie-path-forward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (not (zombie-forward ?z)))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (not (zombie-at ?zb ?fromz)) (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (not (zombie-path-forward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (not (zombie-at ?zb ?fromz)) (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (zombie-path-backward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (zombie-forward ?z))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (not (zombie-at ?zb ?fromz)) (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (not (zombie-path-backward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))

                            
                        )
    )

    (:action stay-still
        :parameters     (?p - player ?pt - tile )
        :precondition   (and (player-alive)
                             (player-at ?p ?pt)
                             (not (interactions ?pt))
                             (not (enemy-interaction ?pt))
                             
                             
                             
                        )
        :effect         (and
                            ;; Fireball movement
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile)
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (not (wall ?fbto)))
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (fireball-at ?fb ?fbto) (enemy-interaction ?fbto))))
                            
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile) 
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (wall ?fbto)) 
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (not (fireball-active ?fb)))))

                            ;; Zombie movement (back-and-forth)
                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (zombie-path-forward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (not (zombie-forward ?z)))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (not (zombie-path-forward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (zombie-path-backward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (zombie-forward ?z))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (not (zombie-path-backward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))
                        )
    )
  

  
    (:action attack-wooden-door
        :parameters     (?p - player ?d - door ?pt - tile ?dt - tile)
        :precondition   (and (player-alive)
                             (player-at ?p ?pt)
                             (player-has-sword)
                             (adjacent ?pt ?dt)
                             (wooden-door-at ?d ?dt)
                             (door-closed ?d)
                             (not (interactions ?pt))
                             (not (enemy-interaction ?pt))
                             
                            )
        :effect         (and
                            (not (door-closed ?d))
                            (not (blocked ?dt))

                            ;; Fireball movement
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile)
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (not (wall ?fbto)))
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (fireball-at ?fb ?fbto) (enemy-interaction ?fbto))))
                            
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile) 
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (wall ?fbto)) 
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (not (fireball-active ?fb)))))

                            ;; Zombie movement (back-and-forth)
                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (zombie-path-forward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (not (zombie-forward ?z)))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (not (zombie-path-forward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (zombie-path-backward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (zombie-forward ?z))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (not (zombie-path-backward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))
                        )
    )

    (:action insert-key
        :parameters     (?p - player ?k - key ?kh - keyhole ?pt - tile ?kht - tile ?d - door ?dt - tile )
        :precondition   (and (player-alive)
                             (player-at ?p ?pt)
                             (keyhole-at ?kh ?kht)
                             (adjacent ?pt ?kht)
                             (player-has-key ?k)
                             (opens ?k ?kh ?d)
                             (metal-door-at ?d ?dt)
                             (door-closed ?d)
                             (not (interactions ?pt))
                             (not (enemy-interaction ?pt))
                             
                             
                             
                             )
        :effect         (and
                            (key-inserted ?k ?kh)
                            (not (player-has-key ?k))
                            (not (door-closed ?dt))
                            (not (blocked ?dt))
                            
                            ;; Fireball movement
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile)
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (not (wall ?fbto)))
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (fireball-at ?fb ?fbto) (enemy-interaction ?fbto))))
                            
                            (forall (?fb - fireball ?fbfrom - tile ?fbto - tile) 
                                (when (and (fireball-active ?fb) (fireball-at ?fb ?fbfrom) (fireball-path ?fb ?fbfrom ?fbto) (wall ?fbto)) 
                                    (and (not (fireball-at ?fb ?fbfrom)) (not (enemy-interaction ?fbfrom)) (not (fireball-active ?fb)))))

                            ;; Zombie movement (back-and-forth)
                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (zombie-path-forward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (not (zombie-forward ?z)))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-forward ?z ?fromz ?toz) (zombie-forward ?z) (not (zombie-path-forward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (zombie-path-backward-last ?z ?toz))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz) (zombie-forward ?z))))

                            (forall (?z - zombie ?fromz - tile ?toz - tile)
                                (when (and (zombie-alive ?z) (zombie-at ?z ?fromz) (zombie-path-backward ?z ?fromz ?toz) (not (zombie-forward ?z)) (not (zombie-path-backward-last ?z ?toz)))
                                    (and (not (zombie-at ?z ?fromz)) (not (enemy-interaction ?fromz)) (zombie-at ?z ?toz) (enemy-interaction ?toz))))
                        )
    )

    (:action die-by-fire
        :parameters (?p - player ?position - tile ?f - fireball)
        :precondition   (and (player-alive)
                             (player-at ?p ?position)
                             (fireball-active ?f)
                             (fireball-at ?f ?position))
        :effect         (and (not (player-alive)))
    )
    
    (:action die-by-zombie
        :parameters (?p - player ?position - tile ?z - zombie)
        :precondition   (and (player-alive)
                             (player-at ?p ?position)
                             (not (player-has-sword))
                             (zombie-at ?z ?position)
                             (zombie-alive ?z))
        :effect         (and (not (player-alive)))
    )

)
