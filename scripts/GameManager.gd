extends Node

var collectedWords = []

func CollectWord(word : String):
	if (!collectedWords.has(word.to_lower())):
		collectedWords.append(word.to_lower())

func HasWord(word : String) -> bool: 
	return collectedWords.has(word.to_lower())
