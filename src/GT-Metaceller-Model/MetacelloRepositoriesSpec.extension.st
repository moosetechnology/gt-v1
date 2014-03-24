Extension { #name : #MetacelloRepositoriesSpec }

{ #category : #'*gt-metaceller-model' }
MetacelloRepositoriesSpec >> repositoryDescriptions [
	^(self list collect: [ :each | each repositoryDescription ])
]
