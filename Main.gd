extends Node2D




var default_save = {"BlueBlock":Vector2(523.505005, 87.032501), "Dog":Vector2(788.158997, 360.600006), "Fire":Vector2(244.850006, 368.333008)}


var save_dic = {}

var save_path = "user://playground_save_test_1.dat"

var autosave_status = false





func _ready():
	print(" ")
	print("Project Start ----------------------------  Project Start")
	print(" ")
	if load_save():
		perform_load(save_dic)

	
	
	
	

var autosave_timer = 60
var autosave_timer_counter = 0


func _process(delta):
	if autosave_status:
		if autosave_timer_counter < autosave_timer:
			autosave_timer_counter += 1
		else:
			autosave_timer_counter = 0
			create_save_file()
			perform_save()
			
		
	






func load_save():
	print("loading from here: ",save_path)
	
	var save = File.new()
	if save.file_exists(save_path):
		save.open(save_path, File.READ)
		save_dic = parse_json(save.get_as_text())
		save.close()
	
		print("loading complete")
		print(" ")
		return true
	else:
		print("file not found")
		print(" ")
		return false
	
	
	
	
	
func perform_load(dic):
	print("performing load")
	for i in dic.keys():
		#print("giving ",i," this: ",dic[i])
		
		var temp_vector = Vector2(dic[i][0], dic[i][1]) #I'm creating this vector cause json doesn't support vectors
		
		get_node(i).load_position(temp_vector)
	print("load performed")
	print(" ")
	

	
	
	

func create_save_file():
	print("save file will be created")
	for i in get_children():
		if i.is_in_group("pawn"):
			save_dic[i.name] = [i.global_position.x, i.global_position.y]		
			
	print("save file created")
	print("save file contents: ", save_dic)	
	print(" ")
	
	




func perform_save():
	print("saving here: ",save_path)
	
	var save = File.new()
	if not save.file_exists(save_path):
		print("file not found. New one will be created")
	save.open(save_path, File.WRITE)
	save.store_line(to_json(save_dic))
	save.close()
	
	print("save complete")
	print(" ")















func _on_Save_pressed():
	create_save_file()
	perform_save()





func _on_WhipeSave_pressed():
	var dir = Directory.new()
	dir.remove(save_path)
	print("save wiped")
	print(" ")



func _on_ResetPosition_pressed():
	perform_load(default_save)
	



func _on_Load_pressed():
	if load_save():
		perform_load(save_dic)



func _on_Autosave_pressed():
	autosave_status = !autosave_status



