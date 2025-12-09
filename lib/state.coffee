module.exports = load: (caller) ->
  
  game_width = GameWidth
  game_height = GameHeight

  midpoint_x = game_width / 2 
  midpoint_y = game_height / 2

  hidden_x = -500
  hidden_y = -500

  ball_start_x = midpoint_x / 2
  ball_start_y = 0

  floor_x = midpoint_x
  floor_y = 600
  
  flipper_left_x = 160
  flipper_left_y = 500
  flipper_right_x = 335
  flipper_right_y = 500

  left_wall_x = 25
  left_wall_y = midpoint_y
  right_wall_x = game_width - left_wall_x
  right_wall_y = midpoint_y

  left_bumper_x = flipper_left_x - 20
  left_bumper_y = flipper_left_y - 20
  right_bumper_x = flipper_right_x + 20
  right_bumper_y = flipper_right_y - 20

  right_outlane_opening_x = midpoint_x + 200
  right_outlane_opening_y = midpoint_y - 75
  left_outlane_opening_x = midpoint_x - 200
  left_outlane_opening_y = midpoint_y - 75

  flipper_rotation_speed = 400
  flipper_revert_speed = 100
  flipper_max_rotation = 0.75  

  collision_groups = {}
  materials = {}
  contact_materials = {}
  groups = {}
  animations = {}

  monster_velocity = 100
  
  cursors = caller.game.input.keyboard.createCursorKeys();
  
  gravity =
    x: 0
    y: 800

  {
    game_width,
    game_height,
    midpoint_x,
    midpoint_y,
    ball_start_x,
    ball_start_y,
    flipper_left_x,
    flipper_left_y,
    flipper_right_x,
    flipper_right_y,
    collision_groups,
    materials,
    contact_materials,
    groups,
    cursors,
    gravity,
    left_bumper_x,
    left_bumper_y,
    right_bumper_x,
    right_bumper_y,
    left_wall_x,
    left_wall_y,
    right_wall_x,
    right_wall_y,
    right_outlane_opening_x,
    left_outlane_opening_x,
    right_outlane_opening_y,
    left_outlane_opening_y,
    floor_x,
    floor_y,
    flipper_rotation_speed,
    flipper_revert_speed,
    flipper_max_rotation,
    hidden_x,
    hidden_y,
    monster_velocity,
  }
