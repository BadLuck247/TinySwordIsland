extends RefCounted
# meta default

## enums
enum PREFAB_LIST {
	DATABASE_UNITS,
	UNIT_WOKER,
	RESOURCE_TREE,
	TILEMAPLAYERS,
}

## const
static var DATABASE_RESOURCES: Dictionary = {
	PREFAB_LIST.RESOURCE_TREE: {
		Scripts.OBJDATA.RTS_OBJ_TYPE: Scripts.OBJDATA.RTS_RESOURCE,
		Scripts.OBJDATA.RESOURCE_TYPE: Scripts.OBJDATA.RESOURCE_WOOD,
		Scripts.OBJDATA.RESOUCE_AMOUNT: 3.24,
		Scripts.OBJDATA.OBJ_ACTION_IDS: [
			Scripts.ACTION_IDS.ACTION_SELECTABLE,
			Scripts.ACTION_IDS.ACTION_GATHER
		],
		Scripts.OBJDATA.TILEMAPLAYERS : TileMapLayer,
		Scripts.OBJDATA.TILE_POSIITONS : {},
		Scripts.OBJDATA.OBJ_STATE: Scripts.STATE_LIST.IDLE
	}
}

static var DATABASE_UNITS: Dictionary = {
	PREFAB_LIST.UNIT_WOKER: {
		Scripts.OBJDATA.RTS_OBJ_TYPE: Scripts.OBJDATA.RTS_UNIT,
		Scripts.OBJDATA.MOVE_SPEED : 350,
		Scripts.OBJDATA.OBJ_ACTION_IDS: [
			Scripts.ACTION_IDS.ACTION_MOVE,
			Scripts.ACTION_IDS.ACTION_SELECTABLE,
			Scripts.ACTION_IDS.ACTION_GATHER
		],
		Scripts.OBJDATA.TILEMAPLAYERS : TileMapLayer,
		Scripts.OBJDATA.TILE_POSIITONS : {},
		Scripts.OBJDATA.RESOUCE_AMOUNT: 0.0,
		Scripts.OBJDATA.GATHERING_AMOUNT_PER_CYCLE: {
			Scripts.OBJDATA.RESOURCE_WOOD: 2.0,
		},
		Scripts.OBJDATA.OBJ_STATE: Scripts.STATE_LIST.IDLE,
	}
}

## public vars
## private vars
## onready vars
# obj_ for node references
## built-in overide methods
## public methods

## private methods
