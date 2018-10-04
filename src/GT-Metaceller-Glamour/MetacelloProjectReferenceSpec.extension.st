Extension { #name : #MetacelloProjectReferenceSpec }

{ #category : #'*gt-metaceller-glamour' }
MetacelloProjectReferenceSpec >> children [ 
	^ self projectReference version spec packages packageSpecsInLoadOrder
]

{ #category : #'*gt-metaceller-glamour' }
MetacelloProjectReferenceSpec >> labelAsText [	
	^ self name, ' ', self versionString
]
