Extension { #name : #String }

{ #category : #'*GT-InspectorExtensions-CoreRoassal' }
String >> asComment [
	self flag: 'Need to be compatible with Pharo 4. Remove me once Moose moves to Pharo 4'.
	^ self asSmalltalkComment
]
