extends RigidBody2D

export (int) var throw_speed: int = 1200
export (int) var drag: int = 500
export (int) var damage_output: int = 50

var player: Node

var grenade_exploded: bool = false
var thrown: bool = false

"""
Funktionen körs då granaten tas fram, sprinten dras och det ger granaten en lifstidstimer.
Swer även till att granten inte gör skada då den inte sprängts än.
"""

func _ready() -> void:
	Stats.grenades_thrown += 1
	visible = true
	$PinPull.play()
	$Timer.start(2)
	$DamageArea/CollisionShape.disabled = true
	$DamageArea/AnimatedSprite.visible = false

"""
Kollar om granaten hålls kvar av spelaren efter aktivation och om den inte har kastat, i så fall följer den spelarens position.
"""

func _physics_process(_delta: float) -> void:
	if PlayerGlobals.holding_grenade and !thrown:
		global_position = player.global_position - Vector2(0, 120)

"""
När denna anropas då granate "_on_Timer_timeout()" körs.
Spelar exposionsljud och -animation samt aktiverar arean som skadar motståndarna om de befinner sig inom den.
"""

func grenade_explosion():
	$Timer.stop()
	$Sprite.visible = false
	sleeping = true
	$GrenadeExplosion.play()
	$CollisionShape.disabled = true
	$DamageArea/CollisionShape.disabled = false
	$DamageArea/AnimatedSprite.visible = true
	$DamageArea/AnimatedSprite.play("default")

"""
Aktiveras då granaten kastats, ger granaten en riktning mot musens position och en rotation.
"""

func grenade_thrown() -> void:
	if not grenade_exploded and not thrown:
		thrown = true
		look_at(get_global_mouse_position())
		apply_impulse(Vector2.ZERO, Vector2(throw_speed, 0).rotated(rotation))

"""
Aktiveras då tiden på granaten gått ut.
Startar expolsionsfunktionen och gör att skärmen skakar.
"""

func _on_Timer_timeout() -> void:
	grenade_exploded = true
	grenade_explosion()
	Shake.start_shake(8, 0.4)

"""
Tar bort granaten då den expolderat.
"""

func _on_GrenadeExplosion_finished() -> void:
	queue_free()

"""
Då explosionsanimationen är klar så avaktiverar den den skadegörande arean.
"""

func _on_AnimatedSprite_animation_finished() -> void:
	$DamageArea/CollisionShape.disabled = true
