
# ------------------------------------------------
# - Paths here are given relative to the root of the repo.
# - New assets should be added both here and preload.coffee
# ------------------------------------------------

BASE_PATH = if typeof __BASE_PATH__ != 'undefined' then __BASE_PATH__ else ''

module.exports = Assets =

  flipper_left:  "#{BASE_PATH}/assets/flipper-left.png"
  flipper_right: "#{BASE_PATH}/assets/flipper-right.png"
  background:    "#{BASE_PATH}/assets/background.png"
  ball:          "#{BASE_PATH}/assets/pinball.png"
  ball_physics:  "#{BASE_PATH}/assets/pinball.json"
  wall:          "#{BASE_PATH}/assets/wall.png"
  floor:         "#{BASE_PATH}/assets/floor.png"
  left_bumper:   "#{BASE_PATH}/assets/left-bumper.png"
  right_bumper:  "#{BASE_PATH}/assets/right-bumper.png"
  right_outlane_opening: "#{BASE_PATH}/assets/right-outlane-opening.png"
  left_outlane_opening: "#{BASE_PATH}/assets/left-outlane-opening.png"
  cloister: "#{BASE_PATH}/assets/cloister.png"
  slobro: "#{BASE_PATH}/assets/slowbro.png"
  kirby_eye: "#{BASE_PATH}/assets/kirby_eye.png"
  kirby_eye_2: "#{BASE_PATH}/assets/kirby_eye_2.png"

  floor_physics:         "#{BASE_PATH}/assets/floor.json"
  flipper_left_physics:  "#{BASE_PATH}/assets/flipper-left.json"
  flipper_right_physics: "#{BASE_PATH}/assets/flipper-right.json"
  right_bumper_physics:  "#{BASE_PATH}/assets/right-bumper.json"
  left_bumper_physics:  "#{BASE_PATH}/assets/left-bumper.json"
  right_outlane_opening_physics: "#{BASE_PATH}/assets/right-outlane-opening.json"
  left_outlane_opening_physics: "#{BASE_PATH}/assets/left-outlane-opening.json"
