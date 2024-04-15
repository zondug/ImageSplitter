extends Node2D

@export var split_delay: float = 0.5
@export var move_distance: float = 20.0
@export var remove_delay: float = 2.0

var texture
var original_sprite
var left_sprite
var right_sprite

func _ready():
	# icon.svg 이미지 로드
	texture = load("res://icon.svg")
	
	# 원본 스프라이트 생성 및 설정
	original_sprite = Sprite2D.new()
	original_sprite.texture = texture
	add_child(original_sprite)
	
	# 0.5초 후에 세로 선 그리기
	await get_tree().create_timer(0.5).timeout
	draw_vertical_line()
	
	# 0.5초 후에 이미지 분리 및 좌우 이동
	await get_tree().create_timer(0.5).timeout
	split_image()
	
	# 1초 후에 스프라이트 제거
	await get_tree().create_timer(1.0).timeout
	#remove_sprites()

func draw_vertical_line():
	if is_instance_valid(original_sprite):
		# 이미지의 크기 가져오기
		var texture_size = texture.get_size()
		
		# 선의 시작점과 끝점 계산 (수직선)
		var start_pos = original_sprite.position - Vector2(0, texture_size.y / 2)
		var end_pos = original_sprite.position + Vector2(0, texture_size.y / 2)
		
		# 선 그리기
		var line = Line2D.new()
		line.points = [start_pos, end_pos]
		line.width = 2.0
		line.default_color = Color.WHITE
		add_child(line)

func split_image():
	# 이미지의 크기 가져오기
	var texture_size = texture.get_size()
	
	# 왼쪽 스프라이트를 감싸는 Node2D 생성
	var left_node = Node2D.new()
	left_node.position = original_sprite.position - Vector2(texture_size.x / 4, 0)
	add_child(left_node)
	
	# 왼쪽 스프라이트 생성 및 설정
	left_sprite = Sprite2D.new()
	left_sprite.texture = texture
	left_sprite.region_enabled = true
	left_sprite.region_rect = Rect2(0, 0, texture_size.x / 2, texture_size.y)
	left_node.add_child(left_sprite)
	
	# 오른쪽 스프라이트를 감싸는 Node2D 생성
	var right_node = Node2D.new()
	right_node.position = original_sprite.position + Vector2(texture_size.x / 4, 0)
	add_child(right_node)
	
	# 오른쪽 스프라이트 생성 및 설정
	right_sprite = Sprite2D.new()
	right_sprite.texture = texture
	right_sprite.region_enabled = true
	right_sprite.region_rect = Rect2(texture_size.x / 2, 0, texture_size.x / 2, texture_size.y)
	right_node.add_child(right_sprite)
	
	# 원본 스프라이트 숨기기
	original_sprite.visible = false
	
	# 지정된 지연 시간 후에 스프라이트 이동
	var tween_left = create_tween()
	tween_left.tween_property(left_node, "position", left_node.position - Vector2(move_distance, 0), split_delay)
	
	var tween_right = create_tween()
	tween_right.tween_property(right_node, "position", right_node.position + Vector2(move_distance, 0), split_delay)

func remove_sprites():
	# 스프라이트 제거
	if is_instance_valid(original_sprite):
		original_sprite.queue_free()
	if is_instance_valid(left_sprite):
		left_sprite.get_parent().queue_free()
	if is_instance_valid(right_sprite):
		right_sprite.get_parent().queue_free()
	queue_free()
