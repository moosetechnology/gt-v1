Extension { #name : #MetacelloRepositoriesSpec }

{ #category : #'*gt-metaceller-model' }
MetacelloRepositoriesSpec >> asCodeStringOn: aStream indent: anIndentSize [
	self list do: [ :each |
		each asCodeStringOn: aStream indent: anIndentSize ]
]
