Extension { #name : #MetacelloProjectSpec }

{ #category : #'*gt-metaceller-model' }
MetacelloProjectSpec >> asCodeStringOn: aStream indent: anIndent specName: aSpecName [
	aStream cr; tab: anIndent; nextPutAll: 'project: '.
	self name asCodeStringOn: aStream.
	aStream nextPutAll: ' with: ['; cr.
	aStream tab: anIndent +1; nextPutAll: aSpecName.
	self configMethodBodyOn: aStream indent: anIndent +1.
	aStream nextPutAll: ' ];'
]
