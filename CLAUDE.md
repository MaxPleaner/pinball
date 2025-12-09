# Pinball Game - Codebase Reference

## Overview
Phaser 2-based 2D pinball simulator written in CoffeeScript with P2 physics engine. Deployed to GitHub Pages at `/PhaserPinball`.

## Architecture

### Entry Point Flow
1. `loader.coffee` - Loads global dependencies (Pixi, P2, Phaser)
2. `lib/game_loader.coffee` - Creates Phaser game instance, adds PlayState
3. `lib/play_state.coffee` - Main game state (modular lifecycle)

### Key Files

**Configuration & Setup:**
- `lib/state.coffee` - Game constants (positions, physics params, gravity: 800px/s²)
- `lib/assets.coffee` - Asset paths with BASE_PATH support for GitHub Pages
- `lib/util.coffee` - Physics helper utilities (P2 wrappers)

**PlayState Lifecycle:**
- `lib/play_state/init.coffee` - Physics initialization
- `lib/play_state/preload.coffee` - Asset loading
- `lib/play_state/create.coffee` - Scene creation (sprites, collisions)
- `lib/play_state/update.coffee` - Frame updates (input handling, flipper rotation)

## Game Mechanics

### Objects
- **Ball**: Spherical physics body
- **Flippers**: Static bodies that rotate (Left: 160,500 | Right: 335,500)
  - Max rotation: 0.75 radians
  - Active speed: 400, Revert: 100
- **Walls**: Boundary elements (left/right sides)
- **Bumpers**: Static collision objects
- **Floor**: Resets ball position on contact
- **Outlane Openings**: Ball loss triggers
- **Monsters**: Animated sprites (velocity: 100px/frame, despawn on ball hit)

### Controls
- **Left Arrow**: Activate left flipper
- **Right Arrow**: Activate right flipper

### Collision Restitution (Bounce)
- Ball-World: 0.1
- Ball-Flippers: 0.2
- Ball-Walls/Bumpers/Outlane: 0.5

## Tech Stack
- Phaser 2.6.2 (WEBGL renderer)
- P2.js physics
- Pixi.js rendering
- CoffeeScript 1.12.4
- Webpack 2.3.2
- Underscore.js

## Development

### Commands
```bash
npm install          # Install dependencies
npm run dev          # Dev server on localhost:8080
npm run deploy       # Production build (minified)
```

### Build Configuration
- `webpack.config.js` - Development (hot reload)
- `webpack.production.config.js` - Production (minification)

### Debugging
Global references available:
- `window.Game` - Phaser game instance
- `window.App` - PlayState instance
- `window.DebugMode` - Toggle P2 debug visualization

## Deployment

### GitHub Pages Setup
- Workflow: `.github/workflows/deploy.yml`
- Triggers on push to `main` branch
- Sets `BASE_PATH=/PhaserPinball` via DefinePlugin
- Deploys to `gh-pages` branch
- Output: `deploy/` directory

### Base Path Pattern
Assets use conditional BASE_PATH:
```coffeescript
BASE_PATH = if typeof __BASE_PATH__ != 'undefined' then __BASE_PATH__ else ''
# Usage: "#{BASE_PATH}/assets/flipper-left.png"
```

## Assets

### Compiled (`/assets/`)
- PNG sprites: background, flippers, ball, walls, bumpers, monsters
- JSON physics files: Polygon collision shapes

### Source (`/assets-src/`)
- GIF animations
- High-res source images
- GIMP project files

## Design Patterns

1. **Module Composition**: PlayState lifecycle methods loaded via `require()`
2. **State Initialization**: Configuration loaded via `Object.assign()`
3. **Utility Mixin**: Helper methods extend PlayState
4. **Collision Callbacks**: P2 impact events with inline handlers
5. **Declarative Physics**: JSON-based collision shape definitions

## Common Tasks

### Adding New Game Object
1. Add sprite in `lib/play_state/create.coffee`
2. Define collision group and material
3. Set restitution value
4. Add position to `lib/state.coffee` if configurable
5. Handle collision callback if needed

### Modifying Physics
- Gravity: `lib/state.coffee` (currently 800px/s²)
- Restitution: `lib/play_state/create.coffee` (contactMaterials)
- Collision shapes: `/assets/*.json` files

### Adding New Assets
1. Place source in `/assets-src/`
2. Export to PNG in `/assets/`
3. Add path to `lib/assets.coffee`
4. Load in `lib/play_state/preload.coffee`
