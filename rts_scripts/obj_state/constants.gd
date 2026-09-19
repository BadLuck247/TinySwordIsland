extends RefCounted
# meta default

## enums
enum STATE_LIST{
	IDLE,
	IDLING,
	IDLED,
	
	MOVE,
	MOVING,
	MOVED,
	
	ATTACK,
	ATTACKING,
	ATTACKED,
	
	GATHER,
	GATHERING,
	GATHERED,
}

enum SIGNAL_LIST {
	FINISHED_IDLE,
	REQUEST_TO_MOVE,
	
	OBJ_ACTION_CYCLE_TIMER_TIMEOUT,
	RESOURCE_IS_EMPTY,
}
## const
## public vars
## private vars
## onready vars
# obj_ for node references
## built-in overide methods
