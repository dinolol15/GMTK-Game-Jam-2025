@tool
class_name StorageStation
extends Station


func _on_cargo_converted(cargo_conversion: CargoConversion) -> void:
	Storage.add_cargo(cargo_conversion.from_cargo)
