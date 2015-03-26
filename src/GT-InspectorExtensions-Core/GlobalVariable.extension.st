Extension { #name : #GlobalVariable }

{ #category : #'*GT-InspectorExtensions-Core' }
GlobalVariable class >> exampleSmalltalk [
	<gtExample>
	^ Smalltalk globals associations detect: [:assoc | assoc key = #Smalltalk ]
]
