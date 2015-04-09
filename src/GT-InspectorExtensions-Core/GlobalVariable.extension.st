Extension { #name : #GlobalVariable }

{ #category : #'*GT-InspectorExtensions-Core' }
GlobalVariable class >> gtExampleSmalltalk [
	<gtExample>
	^ Smalltalk globals associations detect: [:assoc | assoc key = #Smalltalk ]
]
