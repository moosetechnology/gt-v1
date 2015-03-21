Extension { #name : #GlobalVariable }

{ #category : #'*GT-InspectorExtensions-Core' }
GlobalVariable class >> exampleSmalltalk [
	<example>
	^ Smalltalk globals associations detect: [:assoc | assoc key = #Smalltalk ]
]
