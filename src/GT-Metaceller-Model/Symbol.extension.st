Extension { #name : #Symbol }

{ #category : #'*gt-metaceller-model' }
Symbol >> asCodeStringOn: aStream [
	aStream nextPut: $#.
	super asCodeStringOn: aStream
]
