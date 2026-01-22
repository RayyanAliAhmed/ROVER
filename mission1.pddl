(define (problem lunar-mission1)
; Mission 1: A lunar exploration task with one lander, one rover, and one sample.
  (:domain lunar)

; Objects in this world
  (:objects
    lander_1 - lander
    rover_1 - rover
    wp_1 wp_2 wp_3 wp_4 wp_5 - location
  )

  ; Initial world state
  (:init
    ; Lander configuration
    (lander_at lander_1 wp_1)       ; The lander is located at waypoint 1 (The base)

    ; Rover initial conditions
    (at rover_1 wp_1)                  ; Rover starts at the lander's location
    (not (deployed rover_1))            ; Rover hasn't been deployed yet (Must deploy first)
    (not (memory_full rover_1))        ; Rover's memory is empty initially
    (not (has_sample rover_1))           ; Rover doesn't have a sample initially
    (not (lander_with_sample lander_1)) ; Lander doesn't have sample initially

    ; Sample availability
    (sample_available wp_3)         ; The sample is available at wp_3

    ; Map of the terrain
    (connected wp_1 wp_2)
    (connected wp_1 wp_4)
    (connected wp_4 wp_3)
    (connected wp_2 wp_3)
    (connected wp_3 wp_5)
    (connected wp_5 wp_1)

    ; Goal states initially false
    (not (image_saved_from wp_5))
    (not (scan_saved_from wp_5))
  )

  ; All data transmitted and sample stored
  (:goal
    (and
      (image_saved_from wp_5)
      (scan_saved_from wp_5)
      (lander_with_sample lander_1)
    )
  )
)