"
KMRepository reset
"
Class {
	#name : #GTSpotterShortcut,
	#superclass : #KMCategory,
	#category : #'GT-Spotter-UI'
}

{ #category : #'as yet unclassified' }
GTSpotterShortcut class >> isGlobalCategory [
	^ true
]

{ #category : #'as yet unclassified' }
GTSpotterShortcut >> keymapToggle [
	"KMRepository reset"
	<shortcut>
	^ KMKeymap
			shortcut: Character cr command
			action: [ GTSpotter example ]
]
