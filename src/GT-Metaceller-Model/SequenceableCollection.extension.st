Extension { #name : #SequenceableCollection }

{ #category : #'*gt-metaceller-model' }
SequenceableCollection >> repositoryDescriptions [
	^self collect: [ :each | each repositoryDescription ]
]
