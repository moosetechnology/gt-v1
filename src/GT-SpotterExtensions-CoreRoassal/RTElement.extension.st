Extension { #name : #RTElement }

{ #category : #'*GT-SpotterExtensions-CoreRoassal' }
RTElement >> spotterActDefault [
	self view canvas camera translateTo: self position.
	RTBlink on: self.
]
