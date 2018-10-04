Extension { #name : #GTMetacellerVersion }

{ #category : #'*gt-metaceller-glamour' }
GTMetacellerVersion >> asText [
	self isRelease ifTrue: [ ^Text string: self versionNumber attribute: TextEmphasis bold ].
	self isBaseline ifTrue: [ ^Text string: self versionNumber attribute: TextColor red ].
	self isDevelopment ifTrue: [ ^Text string: self versionNumber attribute: TextColor blue ].
	^Text fromString: self versionNumber
]
