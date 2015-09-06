Extension { #name : #RPackage }

{ #category : #'*GT-Inspector-Examples-UI' }
RPackage >> gtExamplesContained [
	^ self classes gather: [ :each | each gtExamples ]
]
