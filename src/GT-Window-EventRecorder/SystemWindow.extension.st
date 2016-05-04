Extension { #name : #SystemWindow }

{ #category : #'*GT-Window-EventRecorder' }
SystemWindow >> windowType [

	^ model ifNil: [ self ]
]
