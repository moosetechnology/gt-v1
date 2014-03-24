Extension { #name : #String }

{ #category : #'*gt-metaceller-model' }
String >> asCodeStringOn: aStream [
	aStream nextPut: $'; nextPutAll: self; nextPut: $'
]
