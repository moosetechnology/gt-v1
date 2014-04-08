Extension { #name : #String }

{ #category : #'*gt-metaceller-stream' }
String >> asCodeStringOn: aStream [
	aStream nextPut: $'; nextPutAll: self; nextPut: $'
]

{ #category : #'*gt-metaceller-stream' }
String class >> codeStreamContents: aBlock [ 
	^self streamContents: [ :s |
		| codeStream |
		codeStream := (GTMetacellerCodeStream on: s).
		aBlock value: codeStream.
		codeStream close ]
]
