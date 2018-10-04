Extension { #name : #Collection }

{ #category : #'*gt-metaceller-glamour' }
Collection >> asMetacellerLabel [
	^String streamContents: [ :s |
		self printMetacellerLabelOn: s ]
]

{ #category : #'*gt-metaceller-glamour' }
Collection >> printMetacellerLabelOn: aStream [
	aStream nextPutAll: '#('.
	self do: [ :each | each printMetacellerLabelOn: aStream ] separatedBy: [ aStream space ].
	aStream nextPut: $)
]
