## Code author: TheColorRed
## Original source: https://github.com/TheColorRed/godot-di/tree/032d213201a87460f64ed3ae98c732ecccb0ad82

## A token that can be used in a DI Provider.
class_name InjectionToken

var token_name: String

## Creates a new InjectionToken with the given name.
## [p_token_name] The name of the token.
func _init(p_token_name: String):
	token_name = p_token_name
