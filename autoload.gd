class_name AutoloadManager extends Object


var get_it: GetIt


const resources := {}


func _init(cache: GetIt) -> void:
	cache.register("autoload", GetIt.new())
	get_it = cache.get_store_item("autoload").get("value")

	handle_load_resources(resources)


func register(name: String, value: Variant) -> void:
	get_it.register(name, value)


func unregister(name: String) -> void:
	get_it.unregister(name)


func get_store_item(name: String) -> Variant:
	return get_it.get_store_item(name)


func get_store_list() -> Array:
	return get_it.get_store_list()


func handle_load_resources(data: Dictionary) -> void:
	if not data.size():
		return


	_load_resources(data)


func _load_resources(data: Dictionary) -> void:
	for target in data.keys():
		if not data.get(target) is Dictionary:
			register(target, data.get(target))
			continue


		if not data.get(target).size():
			return


		for i in data.get(target):
			if data.get(target)[i] is Dictionary:
				continue


			register(target, data.get(target)[i])
