Extension { #name : #RPackageTag }

{ #category : #'*GT-Inspector-Examples-UI' }
RPackageTag >> gtExamplesContained [
	^ self classes gather: [ :each | each gtExamples ]
]
