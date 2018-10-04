Extension { #name : #String }

{ #category : #'*gt-metaceller-glamour' }
String >> asMetacellerLabel [
	^self
]

{ #category : #'*gt-metaceller-glamour' }
String >> printMetacellerLabelOn: aStream [
	self printOn: aStream
]
