Extension { #name : #MetacelloProjectReferenceSpec }

{ #category : #'*gt-metaceller' }
MetacelloProjectReferenceSpec >> children [ 
	^ self projectReference version spec packages packageSpecsInLoadOrder
]

{ #category : #'*gt-metaceller' }
MetacelloProjectReferenceSpec >> labelAsText [	
	^ self name, ' ', self versionString
]
