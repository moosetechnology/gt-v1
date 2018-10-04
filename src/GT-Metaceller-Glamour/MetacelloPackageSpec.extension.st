Extension { #name : #MetacelloPackageSpec }

{ #category : #'*gt-metaceller-glamour' }
MetacelloPackageSpec >> labelAsText [	
	^ self needsSaving
			ifTrue: [ Text string: self file attribute: TextColor blue] 
			ifFalse: [ Text fromString: self file ]
]
