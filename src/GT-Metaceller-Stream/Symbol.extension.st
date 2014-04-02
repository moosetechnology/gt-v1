Extension { #name : #Symbol }

{ #category : #'*gt-metaceller-stream' }
Symbol >> asCodeStringOn: aStream [
	aStream nextPut: $#.
	super asCodeStringOn: aStream
]
