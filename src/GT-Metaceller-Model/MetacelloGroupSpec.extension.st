Extension { #name : #MetacelloGroupSpec }

{ #category : #'*gt-metaceller-model' }
MetacelloGroupSpec >> asCodeStringOn: aStream indent: anIndent specName: aSpecName [
	aStream cr; tab: anIndent; nextPutAll: 'group: '.
	self name asCodeStringOn: aStream.
	aStream nextPutAll: ' with: '.
	self includes asCodeStringOn: aStream.	
	aStream nextPut: $;

]
