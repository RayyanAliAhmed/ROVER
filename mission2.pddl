(define (problem lunar-mission-2)
  (:domain lunar)

  (:objects
    lander_1 lander_2 - lander
    rover_1 rover_2 - rover
    wp_1 wp_2 wp_3 wp_4 wp_5 wp_6 - location
  )

  (:init
; Lander & Rover setup
    (lander_at lander_1 wp_2)
    (lander_at lander_2 wp_6)

; Rover1: already deployed at wp2
    (at rover_1 wp_2)
    (deployed rover_1)
    (not (memory_full rover_1))
    (not (has_sample rover_1))

; Rover2: undeployed
    (at rover_2 wp_6)
    (not (deployed rover_2))
    (not (memory_full rover_2))
    (not (has_sample rover_2))

; Connectivity Map
    (connected wp_1 wp_2) (connected wp_2 wp_1) ; only 2 bidirectional ways
    (connected wp_2 wp_3) 
    (connected wp_2 wp_4) (connected wp_4 wp_2) ; Including this
    (connected wp_3 wp_5)
    (connected wp_5 wp_3)
    (connected wp_5 wp_6)
    (connected wp_4 wp_4)

; Sample Sites
    (sample_available wp_1)
    (sample_available wp_5)
  )

  (:goal
    (and
      ; Save required data
      (image_saved_from wp_3)
      (scan_saved_from wp_4)
      (image_saved_from wp_2)
      (scan_saved_from wp_6)

      ; Collect and store samples
      (lander_with_sample lander_1)
      (lander_with_sample lander_2)
    )
  )
)
