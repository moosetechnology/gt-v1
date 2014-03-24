Extension { #name : #MetacelloRepositorySpec }

{ #category : #'*gt-metaceller-model' }
MetacelloRepositorySpec >> asCodeStringOn: aStream indent: anIndentSize [
	aStream cr; tab: anIndentSize; nextPutAll: 'repository: '.
	self description asCodeStringOn: aStream.
	aStream nextPut: $;
]
