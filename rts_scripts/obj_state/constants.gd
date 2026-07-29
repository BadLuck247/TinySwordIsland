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
	ATTACKED
}

enum SIGNAL_LIST {
	FINISHED_IDLE,
	REQUEST_TO_MOVE,
}
## const
## public vars
## private vars
## onready vars
# obj_ for node references
## built-in overide methods
