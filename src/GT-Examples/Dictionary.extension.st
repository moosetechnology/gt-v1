Extension { #name : #Dictionary }

{ #category : #'*GT-Examples-Core' }
Dictionary >> removeKey: aKey thenDo: aBlock [
	aBlock value: (self removeKey: aKey ifAbsent: [ ^ self ])
]
