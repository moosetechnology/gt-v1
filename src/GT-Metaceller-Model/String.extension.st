Extension { #name : #String }

{ #category : #'*gt-metaceller-model' }
String >> asCodeStringOn: aStream [
	aStream nextPut: $'; nextPutAll: self; nextPut: $'
]

{ #category : #'*gt-metaceller-model' }
String >> asMetacellerVersion [
	^GTMetacellerVersionName on: self
]

{ #category : #'*gt-metaceller-model' }
String class >> codeStreamContents: aBlock [ 
	^self streamContents: [ :s |
		| codeStream |
		codeStream := (GTMetacellerCodeStream on: s).
		aBlock value: codeStream.
		codeStream close ]
]
