Class {
	#name : #GTScreenshooterGlobalShortcut,
	#superclass : #KMCategory,
	#category : #'GT-Screenshooter'
}

{ #category : #testing }
GTScreenshooterGlobalShortcut class >> isGlobalCategory [
	^ true
]

{ #category : #shortcuts }
GTScreenshooterGlobalShortcut >> keymapToggle [
	"KMRepository reset"
	<shortcut>
	^ KMKeymap
			shortcut: Character cr shift
			action: [ self class openGlobalSpotter ]
]

{ #category : #shortcuts }
GTScreenshooterGlobalShortcut >> screenshot [
	<shortcut>
	^ KMKeymap
			shortcut: $p meta shift
			action: [ 
				World submorphs 
					detect: [:each | (each isKindOf: SystemWindow) and: [ each isActive ] ]
					ifFound: [ :window | 
						window exportAsPNGSilently.
						self inform: window externalName, ' exported as PNG' ] ]
]
