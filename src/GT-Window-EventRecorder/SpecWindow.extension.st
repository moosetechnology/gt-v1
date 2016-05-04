Extension { #name : #SpecWindow }

{ #category : #'*GT-Window-EventRecorder' }
SpecWindow >> windowType [

	^ super windowType model ifNil: [ self ]
]
