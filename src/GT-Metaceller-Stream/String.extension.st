Extension { #name : #String }

{ #category : #'*gt-metaceller-stream' }
String >> asCodeStringOn: aStream [
	aStream nextPut: $'; nextPutAll: self; nextPut: $'
]
