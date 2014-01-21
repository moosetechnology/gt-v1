Extension { #name : #KMCategory }

{ #category : #'*gt-inspector' }
KMCategory >> gtDisplayOn: stream [
	^ stream nextPutAll: self name asString
]
