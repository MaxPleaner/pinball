module.exports = setupControls = ->

  # Wait for DOM to be ready
  ready = (fn) ->
    if document.readyState != 'loading'
      fn()
    else
      document.addEventListener 'DOMContentLoaded', fn

  ready ->
    # Get references to controls and value displays
    gravitySlider = document.getElementById('gravity')
    gravityValue = document.getElementById('gravity-value')

    monsterVelocitySlider = document.getElementById('monster-velocity')
    monsterVelocityValue = document.getElementById('monster-velocity-value')

    flipperSpeedSlider = document.getElementById('flipper-speed')
    flipperSpeedValue = document.getElementById('flipper-speed-value')

    flipperRevertSlider = document.getElementById('flipper-revert')
    flipperRevertValue = document.getElementById('flipper-revert-value')

    ballBounceSlider = document.getElementById('ball-bounce')
    ballBounceValue = document.getElementById('ball-bounce-value')

    numMonstersSlider = document.getElementById('num-monsters')
    numMonstersValue = document.getElementById('num-monsters-value')

    resetBtn = document.getElementById('reset-params')

    # Default values
    defaults =
      gravity: 800
      monsterVelocity: 100
      flipperSpeed: 400
      flipperRevert: 100
      ballBounce: 0.5
      numMonsters: 2

    # Get game instance
    getGameState = ->
      window.App

    # Update gravity
    gravitySlider?.addEventListener 'input', (e) ->
      value = parseInt(e.target.value)
      gravityValue.textContent = value
      state = getGameState()
      if state?.game?.physics?.p2
        state.game.physics.p2.gravity.y = value

    # Update monster velocity
    monsterVelocitySlider?.addEventListener 'input', (e) ->
      value = parseInt(e.target.value)
      monsterVelocityValue.textContent = value
      state = getGameState()
      if state
        state.monster_velocity = value

    # Update flipper speed
    flipperSpeedSlider?.addEventListener 'input', (e) ->
      value = parseInt(e.target.value)
      flipperSpeedValue.textContent = value
      state = getGameState()
      if state
        state.flipper_rotation_speed = value

    # Update flipper revert speed
    flipperRevertSlider?.addEventListener 'input', (e) ->
      value = parseInt(e.target.value)
      flipperRevertValue.textContent = value
      state = getGameState()
      if state
        state.flipper_revert_speed = value

    # Update ball bounce (restitution)
    ballBounceSlider?.addEventListener 'input', (e) ->
      value = parseFloat(e.target.value)
      ballBounceValue.textContent = value.toFixed(1)
      state = getGameState()
      if state?.contact_materials
        # Update all ball contact materials
        for key, material of state.contact_materials
          if key.includes('ball')
            material.restitution = value

    # Update number of monsters
    numMonstersSlider?.addEventListener 'input', (e) ->
      targetCount = parseInt(e.target.value)
      numMonstersValue.textContent = targetCount
      state = getGameState()

      if state?.monsters && state?.active_monsters
        # Set the target count in the game state
        state.target_monster_count = targetCount

        # Spawn more monsters if needed
        while state.active_monsters.size < targetCount
          monster = state.spawn_monster()
          break unless monster  # Failed to create, stop trying

        # Despawn monsters if needed
        while state.active_monsters.size > targetCount
          # Get a random active monster
          monsters_array = Array.from(state.active_monsters)
          monster = monsters_array[0]
          monster.body.x = state.hidden_x
          monster.body.y = state.hidden_y
          monster.body.velocity.x = 0
          state.active_monsters.delete(monster)

    # Reset to defaults
    resetBtn?.addEventListener 'click', ->
      gravitySlider.value = defaults.gravity
      gravityValue.textContent = defaults.gravity

      monsterVelocitySlider.value = defaults.monsterVelocity
      monsterVelocityValue.textContent = defaults.monsterVelocity

      flipperSpeedSlider.value = defaults.flipperSpeed
      flipperSpeedValue.textContent = defaults.flipperSpeed

      flipperRevertSlider.value = defaults.flipperRevert
      flipperRevertValue.textContent = defaults.flipperRevert

      ballBounceSlider.value = defaults.ballBounce
      ballBounceValue.textContent = defaults.ballBounce.toFixed(1)

      numMonstersSlider.value = defaults.numMonsters
      numMonstersValue.textContent = defaults.numMonsters

      # Trigger input events to update game
      gravitySlider.dispatchEvent(new Event('input'))
      monsterVelocitySlider.dispatchEvent(new Event('input'))
      flipperSpeedSlider.dispatchEvent(new Event('input'))
      flipperRevertSlider.dispatchEvent(new Event('input'))
      ballBounceSlider.dispatchEvent(new Event('input'))
      numMonstersSlider.dispatchEvent(new Event('input'))
