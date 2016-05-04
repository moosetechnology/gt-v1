Extension { #name : #TickingSpecWindow }

{ #category : #'*GT-Window-EventRecorder' }
TickingSpecWindow >> windowType [

	^ super windowType model ifNil: [ self ]
]
