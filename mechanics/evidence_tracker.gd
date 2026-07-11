extends Node

signal evidence_updated(current: int, total: int)

var current_evidence: int = 0
var total_evidence: int = 5  # set this to however many pieces of evidence exist

func add_evidence() -> void:
	current_evidence += 1
	current_evidence = min(current_evidence, total_evidence)
	evidence_updated.emit(current_evidence, total_evidence)

func reset_evidence() -> void:
	current_evidence = 0
	evidence_updated.emit(current_evidence, total_evidence)

func is_complete() -> bool:
	return current_evidence >= total_evidence
