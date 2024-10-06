extends Control

@onready var label: Label = $Label

func SetText(message : String):
	var regex = RegEx.new()
	regex.compile("[A-Za-z']+")
	var wordResults = regex.search_all(message)
	var index = 0
	for word in wordResults:
		var ws = word.get_string()
		while (message[index] != ws[0]):
				index += 1
		if(!GameManager.HasWord(ws)):
			for i in ws.length():
				message[index] = '-'
				i += 1
				index += 1
		else:
			for i in ws.length():
				i += 1
				index += 1
	label.text = message
