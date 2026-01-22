(define (problem lunar-mission3)
  ; Mission 3: Coordinated rover–astronaut operations
  (:domain lunar-extended)


  (:objects
    ; Lander, Rover, Waypoint, Sample (Same as Mission 2)
    lander_1 lander_2 - lander
    rover_1 rover_2 - rover
    wp_1 wp_2 wp_3 wp_4 wp_5 wp_6 - waypoint
    sample_1 sample_2 - sample

    ; Extra objects: Astronauts and Internal Lander Areas
    alice bob - astronaut
    control_1 dock_1 control_2 dock_2 - area
  )


  (:init
    ; Lander locations
    (at-lander lander_1 wp_2)
    (at-lander lander_2 wp_6)

    ; Rover–lander associations
    (rover-of rover_1 lander_1)
    (rover-of rover_2 lander_2)

    ; Rover 1 status (Deployed AWAY from lander_1 at WP3)
    (deployed rover_1)
    (at rover_1 wp_3)                   ; Starts at WP3, MUST return to WP2 (lander_1)
    (empty-memory rover_1)
    (not (sample-collected rover_1))

    ; Rover 2 status (Starts undeployed AWAY from lander_2 at WP4)
    (empty-memory rover_2)
    (not (deployed rover_2))
    (at rover_2 wp_4)                   ; Starts at WP4, must return to WP6 (lander_2)
    (not (sample-collected rover_2))

    ; Initial state for all data/samples (No data/samples collected or stored yet)
    (not (has-image rover_1)) (not (has-image rover_2))
    (not (has-scan rover_1)) (not (has-scan rover_2))
    (not (image-transmitted rover_1)) (not (image-transmitted rover_2))
    (not (scan-transmitted rover_1)) (not (scan-transmitted rover_2))
    (not (sample-stored lander_1)) (not (sample-stored lander_2))

    ; Sample site locations
    (at-sample-site sample_1 wp_5)
    (at-sample-site sample_2 wp_1)

    ; Visibility areas for imaging
    (visible wp_2) (visible wp_3) (visible wp_4) (visible wp_6)

    ; Figure 3 Map
    (connected wp_1 wp_2) (connected wp_2 wp_1)  ; 2 way
    (connected wp_2 wp_3)                       ; 1 way
    (connected wp_2 wp_4) (connected wp_4 wp_2)  ; 2 way
    (connected wp_3 wp_5) (connected wp_5 wp_3)  ; 2 way
    (connected wp_5 wp_6)                       ; 1 way
    (connected wp_6 wp_4)                    ; 1 way

    ; Internal lander structure mappings
    (area-of control_1 lander_1) (area-of dock_1 lander_1)
    (area-of control_2 lander_2) (area-of dock_2 lander_2)

    ; Room designations
    (is-control-room control_1) (is-control-room control_2)
    (is-docking-bay dock_1) (is-docking-bay dock_2)

    ; Astronaut initial positions
    (astronaut-in alice dock_1)        ; Alice begins in the docking bay of lander 1
    (astronaut-in bob control_2)       ; Bob begins in the control room of lander 2
  )

  ; Goal: The rover must be at the lander, and the astronaut must be in the control room for the transmit/store actions to succeed.
  (:goal (and
    ; Total of 2 images and 2 scans must be transmitted
    (image-transmitted rover_1)
    (scan-transmitted rover_1)
    (image-transmitted rover_2)
    (scan-transmitted rover_2)

    ; Both samples stored at the landers
    (sample-stored lander_1)
    (sample-stored lander_2)
  ))
)