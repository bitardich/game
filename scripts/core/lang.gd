### TODO IT PLS
extends Node

signal lang_changed

var current_lang: String = "en"

func detect_sys_language(): # узнаем системный язык
	var system_lang = OS.get_locale_language()
