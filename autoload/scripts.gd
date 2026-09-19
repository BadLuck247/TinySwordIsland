extends Node
# meta default

## enums
## const
const ACTION_MANAGER = preload("res://rts_scripts/obj_actions/main_manager.gd")
const DATA_MANAGER = preload("res://rts_scripts/obj_data/main_manager.gd")
const STATE_MANAGER = preload("res://rts_scripts/obj_state/main_manager.gd")
const PREFAB_MANAGER = preload("res://rts_scripts/obj_prefab/main_manager.gd")
const TILE_MANAGER = preload("res://rts_scripts/obj_tilemap/main_manager.gd")
const RTS_WORLD = preload("res://rts_systems/rts_world/main.gd")
const DATABASE = preload("res://rts_scripts/obj_prefab/database.gd")
const PREFAB_LIST = preload("res://rts_scripts/obj_prefab/database.gd").PREFAB_LIST
const PREFAB_INITIALIZER =  preload("res://rts_scripts/obj_prefab/initializer.gd")
# Aliases
const ACTIONS = preload("res://rts_scripts/obj_actions/main_manager.gd").ACTION_SCRIPTS
const ACTION_IDS = preload("res://rts_scripts/obj_actions/constants.gd").ACTION_LIST
const OBJDATA = preload("res://rts_scripts/obj_data/constants.gd").DATA_LIST
const STATE_LIST =  preload("res://rts_scripts/obj_state/constants.gd").STATE_LIST
const STATE_SIGNALS =  preload("res://rts_scripts/obj_state/constants.gd").SIGNAL_LIST

## public vars
## private vars
## onready vars
# obj_ for node references
## built-in overide methods
## private methods
