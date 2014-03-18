Extension { #name : #GTMetacellerConfiguration }

{ #category : #'*gt-metaceller-glamour' }
GTMetacellerConfiguration >> infoText [
	| retVal |
	retVal := Text new.
	retVal append: 'Name: ', self shortName; append: String cr.
	retVal append: (Text string: 'Stable: ' attribute: TextEmphasis bold).
	self stableVersion
		ifNil: [ retVal append: '-' ]
		ifNotNilDo: [ :ver | retVal append: ver asText ].
	retVal append: String cr.
	retVal append: (Text string: 'Development: ' attribute: TextColor blue).
	self developmentVersion
		ifNil: [ retVal append: '-' ]
		ifNotNilDo: [ :ver | retVal append: ver asText ].
	retVal append: String cr.
	retVal append: (Text string: 'Bleeding edge: ' attribute: TextColor red).
	self bleedingEdgeVersion
		ifNil: [ retVal append: '-' ]
		ifNotNilDo: [ :ver | retVal append: ver asText ].
	retVal append: String cr.
	^retVal
]

{ #category : #'*gt-metaceller-glamour' }
GTMetacellerConfiguration >> installDialog [
	^GTMetacellerInstaller openOn: self
]
