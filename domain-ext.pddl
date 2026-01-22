(define (domain lunar-extended)
  (:requirements :strips :typing)

; objects
  (:types
    lander rover waypoint sample astronaut area
  )

; realities
  (:predicates
    ;; Location and connection
    (at ?r - rover ?w - waypoint)
    (at-lander ?l - lander ?w - waypoint)
    (connected ?from - waypoint ?to - waypoint)

    ;; Rover status and relationships
    (deployed ?r - rover)
    (rover-of ?r - rover ?l - lander)
    (empty-memory ?r - rover)
    (has-image ?r - rover)
    (has-scan ?r - rover)
    (image-transmitted ?r - rover)
    (scan-transmitted ?r - rover)
    (sample-collected ?r - rover)
    (sample-stored ?l - lander)
    (at-sample-site ?s - sample ?w - waypoint)
    (visible ?w - waypoint)

    ;; Astronaut and base areas
    (astronaut-in ?a - astronaut ?area - area)
    (area-of ?area - area ?l - lander)
    (is-control-room ?area - area)
    (is-docking-bay ?area - area)
  )

;ACTIONS
; Move an astronaut between areas within the same lander
  (:action move-astronaut
    :parameters (?a - astronaut ?from - area ?to - area ?l - lander)
    :precondition (and
      (astronaut-in ?a ?from)
      (area-of ?from ?l)
      (area-of ?to ?l)
    )
    :effect (and
      (not (astronaut-in ?a ?from))
      (astronaut-in ?a ?to)
    )
  )

; Deploy a rover from the lander (requires astronaut in docking bay)
  (:action deploy
    :parameters (?r - rover ?l - lander ?loc - waypoint ?a - astronaut ?area - area)
    :precondition (and
      (at-lander ?l ?loc)
      (rover-of ?r ?l)
      (not (deployed ?r))
      (astronaut-in ?a ?area)
      (area-of ?area ?l)
      (is-docking-bay ?area)
    )
    :effect (and
      (deployed ?r)
      (at ?r ?loc)
    )
  )

; Move a rover between connected waypoints
  (:action move
    :parameters (?r - rover ?from - waypoint ?to - waypoint)
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

; Capture an image if the rover has free memory and visibility
  (:action capture-image
    :parameters (?r - rover ?loc - waypoint)
    :precondition (and
      (at ?r ?loc)
      (empty-memory ?r)
      (visible ?loc)
    )
    :effect (and
      (not (empty-memory ?r))
      (has-image ?r)
    )
  )

; Capture a scan (no visibility required)
  (:action capture-scan
    :parameters (?r - rover ?loc - waypoint)
    :precondition (and
      (at ?r ?loc)
      (empty-memory ?r)
    )
    :effect (and
      (not (empty-memory ?r))
      (has-scan ?r)
    )
  )

; Pick up a sample at the rover's location
  (:action pickup-sample
    :parameters (?r - rover ?loc - waypoint)
    :precondition (and
      (at ?r ?loc)
      (deployed ?r)
      (not (sample-collected ?r))
    )
    :effect (sample-collected ?r)
  )

; Transmit image data back to the lander (requires astronaut in control room)
  (:action transmit-image
    :parameters (?r - rover ?l - lander ?loc - waypoint ?a - astronaut ?area - area)
    :precondition (and
      (has-image ?r)
      (rover-of ?r ?l)
      (at-lander ?l ?loc)
      (at ?r ?loc)
      (astronaut-in ?a ?area)
      (area-of ?area ?l)
      (is-control-room ?area)
    )
    :effect (and
      (not (has-image ?r))
      (empty-memory ?r)
      (image-transmitted ?r)
    )
  )

; Transmit scan data back to the lander (requires astronaut in control room)
  (:action transmit-scan
    :parameters (?r - rover ?l - lander ?loc - waypoint ?a - astronaut ?area - area)
    :precondition (and
      (has-scan ?r)
      (rover-of ?r ?l)
      (at-lander ?l ?loc)
      (at ?r ?loc)
      (astronaut-in ?a ?area)
      (area-of ?area ?l)
      (is-control-room ?area)
    )
    :effect (and
      (not (has-scan ?r))
      (empty-memory ?r)
      (scan-transmitted ?r)
    )
  )

  ;; Store a collected sample in the lander (requires astronaut in docking bay)
  (:action store-sample
    :parameters (?r - rover ?l - lander ?loc - waypoint ?a - astronaut ?area - area)
    :precondition (and
      (sample-collected ?r)
      (at ?r ?loc)
      (at-lander ?l ?loc)
      (not (sample-stored ?l))
      (astronaut-in ?a ?area)
      (area-of ?area ?l)
      (is-docking-bay ?area)
    )
    :effect (and
      (not (sample-collected ?r))
      (sample-stored ?l)
    )
  )
)
