"
KMRepository reset
"
Class {
	#name : #GTSpotterGlobalShortcut,
	#superclass : #KMCategory,
	#classInstVars : [
		'globalSpotter'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #testing }
GTSpotterGlobalShortcut class >> isGlobalCategory [
	^ true
]

{ #category : #accessing }
GTSpotterGlobalShortcut class >> openGlobalSpotter [
	globalSpotter 
		ifNotNil: [ globalSpotter delete ].
	globalSpotter := GTSpotterMorph new width: 630; doLayout.
	globalSpotter spotterModel: GTSpotter new.
	globalSpotter openInWorld.
	globalSpotter bounds: (globalSpotter bounds translateBy: ((globalSpotter world center - globalSpotter center) - (0@200))).
	globalSpotter spotterModel setText: '' from: nil.
	^ globalSpotter
]

{ #category : #'as yet unclassified' }
GTSpotterGlobalShortcut >> keymapToggle [
	"KMRepository reset"
	<shortcut>
	^ KMKeymap
			shortcut: Character cr command
			action: [ self class openGlobalSpotter ]
]

{ #category : #'as yet unclassified' }
GTSpotterGlobalShortcut >> openGlobalSpotter [
	
]
