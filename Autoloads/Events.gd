extends EventsBase

# warnings-disable

#### OBJECTS USAGE ####

signal try_interact(obstacle)
signal interaction_succeed(obstacle)
signal interaction_failed(obstacle)

signal increment_level_variation()
signal decrement_level_variation()
signal go_to_level_variation(variation_id)

signal approch_interactable(obj)
signal recede_interactable(obj)

#### SOUNDS ####

signal play_sound_effect(stream_player)
