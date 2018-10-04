"
We only need this specialization so that we can delete the text area on escape
"
Class {
	#name : #GTPresenterNoteEditingArea,
	#superclass : #RubEditingArea,
	#category : #'GT-PresenterNote'
}

{ #category : #'event handling' }
GTPresenterNoteEditingArea >> escapePressed [
	^ self delete
]
