Extension { #name : #WDApplication }

{ #category : #'*GT-InspectorExtensions-Woden' }
WDApplication >> window [
	window := self createWindow.
	window application: self.
	^ window
]
