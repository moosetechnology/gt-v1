Extension { #name : #UndefinedObject }

{ #category : #'*GT-Chatter' }
UndefinedObject >> visitChatterMessage: aMessage factory: aGTCMessageFactory [ 
	^ aMessage acceptUndefinedObject: self factory: aGTCMessageFactory
]
