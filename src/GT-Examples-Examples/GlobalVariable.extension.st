Extension { #name : #GlobalVariable }

{ #category : #'*GT-Examples-Examples' }
GlobalVariable class >> gtExampleSmalltalk [
	<gtExample>
	^ Smalltalk globals associations detect: [:assoc | assoc key = #Smalltalk ]
]
