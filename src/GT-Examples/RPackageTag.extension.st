Extension { #name : #RPackageTag }

{ #category : #'*GT-Examples-UI' }
RPackageTag >> gtExamplesContained [
	^ self classes gather: [ :each | each gtExamples ]
]
