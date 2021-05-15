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
signal invisible_spectral_obj_entered(obj, player_velocity_dir)

#### SOUNDS ####

signal next_level_query()

