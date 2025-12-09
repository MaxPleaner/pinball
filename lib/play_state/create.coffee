module.exports = -> 

# ------------------------------------------------
# add assets to page
# these sections can be rearranged to change the display order (z-index)
# ------------------------------------------------

    # Background needs to be added first
    @background = @set_game_size_and_background(
        @game_width, @game_height, 'background'
    )

    # ball
    @ball = @add_p2_sprite @ball_start_x, @ball_start_y, 'ball'
    @add_physics_file(@ball, 'ball_physics', 'ball')
    @collide_world_bounds(@ball)

    # floor
    @floor = @add_p2_sprite @floor_x, @floor_y, 'floor'
    @add_physics_file @floor, 'floor_physics', 'floor'
    @make_static @floor
    @turn_off_gravity @floor

    # wall
    @walls = []
    @groups.walls = @add_group()
    @left_wall = @add_p2_sprite @left_wall_x, @left_wall_y, 'wall'
    @right_wall = @add_p2_sprite @right_wall_x, @right_wall_y, 'wall'
    @right_wall.rotation = Math.pi
    for wall in [@left_wall, @right_wall]
        @make_static wall
        @turn_off_gravity wall
        @groups.walls.add wall
        @walls.push wall

    # bumpers
    @bumpers = []
    @groups.bumpers = @add_group()
    @left_bumper = @add_p2_sprite @left_bumper_x, @left_bumper_y, 'left_bumper'
    @right_bumper = @add_p2_sprite @right_bumper_x, @right_bumper_y, 'right_bumper'
    @add_physics_file(@left_bumper, 'left_bumper_physics', 'left_bumper')
    @add_physics_file(@right_bumper, 'right_bumper_physics', 'right_bumper')
    for bumper in [@left_bumper, @right_bumper]
        @make_static bumper
        @turn_off_gravity bumper
        @groups.bumpers.add bumper
        @bumpers.push bumper

    # flippers
    @flippers = []
    @groups.flippers = @add_group()
    @flipper_left = @add_p2_sprite @flipper_left_x, @flipper_left_y, 'flipper_left'
    @flipper_right = @add_p2_sprite @flipper_right_x, @flipper_right_y, 'flipper_right'
    @add_physics_file(@flipper_left, 'flipper_left_physics', 'flipper-left')
    @add_physics_file(@flipper_right, 'flipper_right_physics', 'flipper-right')
    for flipper in [@flipper_left, @flipper_right]
        @make_static flipper
        @turn_off_gravity flipper
        @groups.flippers.add flipper
        @flippers.push flipper

    # outlane openings
    @outlane_openings = []
    @groups.outlane_openings = @add_group()
    @right_outlane_opening = @add_p2_sprite(
        @right_outlane_opening_x, @right_outlane_opening_y, "right_outlane_opening"
    )
    @left_outlane_opening = @add_p2_sprite(
        @left_outlane_opening_x, @left_outlane_opening_y, "left_outlane_opening"
    )
    @add_physics_file(
        @right_outlane_opening, "right_outlane_opening_physics", "right_outlane_opening"
    )
    @add_physics_file(
        @left_outlane_opening, "left_outlane_opening_physics", "left_outlane_opening"
    )
    for outlane_opening in [@right_outlane_opening, @left_outlane_opening]
        @make_static outlane_opening
        @turn_off_gravity outlane_opening
        @groups.outlane_openings.add outlane_opening
        @outlane_openings.push outlane_opening

    # monster animations
    @cloister = @add_p2_sprite @hidden_x, @hidden_y, 'cloister'
    @slobro = @add_p2_sprite @hidden_x, @hidden_y, 'slobro'
    @kirby_eye = @add_p2_sprite @hidden_x, @hidden_y, 'kirby_eye'
    @kirby_eye_2 = @add_p2_sprite @hidden_x, @hidden_y, 'kirby_eye_2'

    @monsters = [@cloister, @slobro, @kirby_eye, @kirby_eye_2]
    @active_monsters = new Set()
    @monsters.forEach (monster) =>
        @make_static monster
        @turn_off_gravity monster
        monster.animations.add("walk")
        monster.animations.play "walk", 10, true

    gen_monster = =>
        x = @random_int(15, @game_width - 80)
        y = @random_int(15, @midpoint_y - 80)
        monster = @random_from_list(_.difference(@monsters, @active_monsters))
        if monster
            monster.body.x = x
            monster.body.y = y
            facing_right = Math.random() < 0.5
            monster.body.velocity.x = @monster_velocity * (
                if facing_right then 1 else -1
            )
            if !facing_right
                monster.scale.x *= -1
            @active_monsters.add monster
            monster

    for i in [1..2]
        gen_monster()

    # UI stuff
    style = 
        font: "bold 32px Arial"
        fill: "#fff",
        boundsAlignH: "center",
        boundsAlignV: "middle"

# ------------------------------------------------
# collisions and materials
#
# Only a collision is necessary to define
# Materials just give added control (such as bounce / friction / etc)
# ------------------------------------------------
    
    # define collision groups
    @collision_groups.ball = @create_collision_group()
    @collision_groups.flippers = @create_collision_group()
    @collision_groups.walls = @create_collision_group()
    @collision_groups.floor = @create_collision_group()
    @collision_groups.bumpers = @create_collision_group()
    @collision_groups.outlane_openings = @create_collision_group()
    @collision_groups.monsters = @create_collision_group()

    # apply collision groups
    @set_sprite_collision_group(@ball, @collision_groups.ball)
    @set_sprite_collision_group @floor, @collision_groups.floor
    @flippers.forEach (flipper) =>
        @set_sprite_collision_group flipper, @collision_groups.flippers    
    @walls.forEach (wall) =>
        @set_sprite_collision_group wall, @collision_groups.walls
    @bumpers.forEach (bumper) =>
        @set_sprite_collision_group bumper, @collision_groups.bumpers
    @outlane_openings.forEach (outlane_opening) =>
        @set_sprite_collision_group outlane_opening, @collision_groups.outlane_openings
    @monsters.forEach (monster) =>
        @set_sprite_collision_group monster, @collision_groups.monsters

    # connect collision groups
    # everything needs to be here twice

    # First for the ball => other object
    @ball.body.collides @collision_groups.flippers
    @ball.body.collides @collision_groups.walls
    @ball.body.collides @collision_groups.floor
    @ball.body.collides @collision_groups.bumpers
    @ball.body.collides @collision_groups.outlane_openings
    @ball.body.collides @collision_groups.monsters

    # Then for other object => ball

    floor_and_ball_collision = (floor, ball) =>
        ball.y = 0
        ball.x = @midpoint_x
        ball.velocity.x = 90 * (if Math.random() > 0.5 then 1 else -1)

    monster_and_ball_collision = (monster, ball) =>
        monster.x = @hidden_x
        monster.y = @hidden_y
        @active_monsters.delete(monster)
        gen_monster()

    @floor.body.collides @collision_groups.ball, floor_and_ball_collision
    @monsters.forEach (monster) =>
        monster.body.collides @collision_groups.ball, monster_and_ball_collision

    ["flippers", "walls", "bumpers", "outlane_openings"].forEach (group_name) =>
        @groups[group_name].forEach (item) =>
            item.body.collides @collision_groups.ball

    @materials.world = @add_world_material 'world_material'
    @materials.ball = @add_sprite_material @ball, 'ball_material'
    @materials.flippers = @add_sprite_material @flippers..., 'flippers_material'
    @materials.bumpers = @add_sprite_material @bumpers..., 'bumpers_material'
    @materials.walls = @add_sprite_material @walls..., 'walls_material'
    @materials.outlane_openings = @add_sprite_material(
        @outlane_openings..., 'outlane_openings_material'
    )

    # contact materials - this is where physics of the contact can be customized
    @contact_materials.ball_and_world = @add_contact_material(
      @materials.ball,
      @materials.world,
      restitution: 0.1
    )

    @contact_materials.ball_and_flippers = @add_contact_material(
        @materials.ball,
        @materials.flippers,
        restitution: 0.2
    )

    @contact_materials.ball_and_wall = @add_contact_material(
        @materials.ball,
        @materials.walls,
        restitution: 0.5
    )

    @contact_materials.ball_and_bumper = @add_contact_material(
        @materials.ball,
        @materials.bumpers,
        restitution: 0.5
    )

    @contact_materials.ball_and_outlane_opening = @add_contact_material(
        @materials.ball,
        @materials.outlane_openings,
        restitution: 0.5
    )
