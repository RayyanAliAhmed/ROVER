(define (domain lunar)
  (:requirements :strips :typing :negative-preconditions)

; What is there in this world
  (:types 
    lander rover location
  )

; What is true
  (:predicates
    (at ?r - rover ?l - location)              ; Rover’s current location
    (lander_at ?ld - lander ?l - location)     ; Lander’s fixed location
    (connected ?from - location ?to - location); Path between two waypoints
    (deployed ?r - rover)                      ; Rover deployed and active
    
    (memory_full ?r - rover)                   ; True if memory slot is occupied
    (image_origin ?r - rover ?l - location)    ; Image taken at a location
    (scan_origin ?r - rover ?l - location)     ; Scan taken at a location

    (sample_available ?l - location)           ; Sample exists at location
    (has_sample ?r - rover)                    ; Rover carrying sample
    (lander_with_sample ?ld - lander)          ; Lander has received sample

    (image_saved_from ?l - location)           ; Goal: image saved from location
    (scan_saved_from ?l - location)            ; Goal: scan saved from location
  )

; All the logics (before and after)
  (:action deploy_rover
    :parameters (?r - rover ?ld - lander ?l - location)
    :precondition (and
      (lander_at ?ld ?l)
      (at ?r ?l)
      (not (deployed ?r))
    )
    :effect (and
      (deployed ?r)
      (at ?r ?l)
    )
  )

  (:action move
    :parameters (?r - rover ?from - location ?to - location)
    :precondition (and 
      (at ?r ?from)
      (connected ?from ?to)
      (deployed ?r)
    )
    :effect (and 
      (not (at ?r ?from))
      (at ?r ?to)
    )
  )
  
  (:action take_image
    :parameters (?r - rover ?l - location)
    :precondition (and 
      (at ?r ?l)
      (deployed ?r)
      (not (memory_full ?r))
    )
    :effect (and 
      (image_origin ?r ?l)
      (memory_full ?r)
    )
  )

  (:action do_scan
    :parameters (?r - rover ?l - location)
    :precondition (and 
      (at ?r ?l)
      (deployed ?r)
      (not (memory_full ?r))
    )
    :effect (and 
      (scan_origin ?r ?l)
      (memory_full ?r)
    )
  )

  (:action transmit_image
    :parameters (?r - rover ?ld - lander ?l_lander - location ?l_origin - location)
    :precondition (and 
      (lander_at ?ld ?l_lander)
      (at ?r ?l_lander)
      (image_origin ?r ?l_origin)
      (memory_full ?r)
    )
    :effect (and 
      (image_saved_from ?l_origin)
      (not (image_origin ?r ?l_origin))
      (not (memory_full ?r))
    )
  )

  (:action transmit_scan
    :parameters (?r - rover ?ld - lander ?l_lander - location ?l_origin - location)
    :precondition (and 
      (lander_at ?ld ?l_lander)
      (at ?r ?l_lander)
      (scan_origin ?r ?l_origin)
      (memory_full ?r)
    )
    :effect (and 
      (scan_saved_from ?l_origin)
      (not (scan_origin ?r ?l_origin))
      (not (memory_full ?r))
    )
  )

  (:action sample_collect
    :parameters (?r - rover ?l - location)
    :precondition (and 
      (at ?r ?l)
      (deployed ?r)
      (sample_available ?l)
      (not (has_sample ?r))
    )
    :effect (and 
      (has_sample ?r)
      (not (sample_available ?l))
    )
  )

  (:action store_sample
    :parameters (?r - rover ?ld - lander ?l - location)
    :precondition (and 
      (at ?r ?l)
      (lander_at ?ld ?l)
      (has_sample ?r)
      (not (lander_with_sample ?ld))
    )
    :effect (and 
      (lander_with_sample ?ld)
      (not (has_sample ?r))
    )
  )
)
