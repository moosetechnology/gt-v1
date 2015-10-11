Extension { #name : #WDApplication }

{ #category : #'*GT-InspectorExtensions-Woden' }
WDApplication >> morphicWindow [
	window := self createMorphicWindow.
	window application: self.
	^ window
]

{ #category : #'*GT-InspectorExtensions-Woden' }
WDApplication >> window [
	window := self createWindow.
	window application: self.
	^ window
]
