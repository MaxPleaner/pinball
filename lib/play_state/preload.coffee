module.exports = ->

 # Background
  @load.image 'background', @Assets.background

  # Non animated playfield objects
  @load.image 'ball', @Assets.ball
  @load.image 'flipper_left', @Assets.flipper_left
  @load.image 'flipper_right', @Assets.flipper_right
  @load.image 'wall', @Assets.wall
  @load.image 'floor', @Assets.floor
  @load.image 'left_bumper', @Assets.left_bumper
  @load.image 'right_bumper', @Assets.right_bumper
  @load.image "right_outlane_opening", @Assets.right_outlane_opening
  @load.image "left_outlane_opening", @Assets.left_outlane_opening  

  # Animated playfield objects
  @load.spritesheet "cloister", @Assets.cloister, 55, 48, 5
  @load.spritesheet "slobro", @Assets.slobro, 55, 48, 5
  @load.spritesheet "kirby_eye", @Assets.kirby_eye, 55, 48, 4
  @load.spritesheet "kirby_eye_2", @Assets.kirby_eye_2, 55, 48, 4

  # Hit boxes
  @load.physics 'ball_physics', @Assets.ball_physics
  @load.physics 'floor_physics', @Assets.floor_physics
  @load.physics 'flipper_left_physics', @Assets.flipper_left_physics
  @load.physics 'flipper_right_physics', @Assets.flipper_right_physics
  @load.physics 'left_bumper_physics', @Assets.left_bumper_physics
  @load.physics 'right_bumper_physics', @Assets.right_bumper_physics
  @load.physics "right_outlane_opening_physics", @Assets.right_outlane_opening_physics
  @load.physics "left_outlane_opening_physics", @Assets.left_outlane_opening_physics
