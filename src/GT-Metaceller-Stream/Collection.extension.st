Extension { #name : #Collection }

{ #category : #'*gt-metaceller-stream' }
Collection >> asCodeStringOn: aStream [
	aStream nextPutAll: '#( '.
	self do: [ :each | each asCodeStringOn: aStream ] separatedBy: [ aStream space ].
	aStream nextPut: $)
]
