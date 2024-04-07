class_name Autoload extends Object


const data := {
	#"redux": preload("res://features/counter/scripts/counter_reducers.gd"),
	"counter": {
		"constants": preload("res://features/counter/scripts/counter_constants.gd"),
		"actions": preload("res://features/counter/scripts/counter_actions.gd"),
		"reducers": preload("res://features/counter/scripts/counter_reducers.gd")
	}
}


var default := func(get_it: Dictionary) -> Dictionary:
	var autoload := func(store: Dictionary) -> void:
		var cache := {}

		for target in data:
			cache[target] = {}


			if data.get(target) is Dictionary:
				for item in data.get(target):
					if not data.get(target).get(item) is GDScript:
						continue


					cache[target][item] = data.get(target).get(item).new()


				store.get("register").call(target, cache.get(target))
				cache = {}

				return


			store.get("register").call(target, data.get(target).new())
			cache = {}


	var handle_autoload := func() -> void:
		if not get_it.get("get_store_item").call("autoload").size():
			get_it.get("register").call("autoload", [])


		return autoload.call(GetIt.get_instance.call(get_it.get("get_store_item").call("autoload").get("value")))


	return {
		"handle_autoload": handle_autoload,
	}


var get_instance := func(get_it: Dictionary) -> Dictionary:
	return default.call(get_it)
