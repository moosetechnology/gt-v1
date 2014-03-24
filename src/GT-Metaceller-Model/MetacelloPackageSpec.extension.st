Extension { #name : #MetacelloPackageSpec }

{ #category : #'*GT-Metaceller-Model' }
MetacelloPackageSpec >> asCodeStringOn: aStream indent: anIndent specName: aSpecName [
	| needsWith |
	needsWith := file ~~ nil.
	needsWith := needsWith or: [ self repositorySpecs size > 0 ].
	needsWith := needsWith or: [ self getPreLoadDoIt ~~ nil ].
	needsWith := needsWith or: [ self getPostLoadDoIt ~~ nil ].
	needsWith := needsWith or: [ (self requires isEmpty and: [ self includes isEmpty and: [self answers isEmpty ]]) not ].
	aStream cr; tab: anIndent; nextPutAll: 'package: '.
	self name asCodeStringOn: aStream.
	needsWith
		ifTrue: [
			aStream nextPutAll: ' with: ['; cr.
			aStream tab: anIndent +1; nextPutAll: aSpecName.
			self configMethodBodyOn: aStream hasName: true indent: anIndent + 2.
			aStream nextPutAll: ' ];' ]
		ifFalse: [ aStream nextPut: $; ]
]

{ #category : #'*GT-Metaceller-Model' }
MetacelloPackageSpec >> hasNewerVersionsFrom: version [
	| g |
	g := Gofer new.
	version spec repositories list do: [:each | g url: each name ].
	g package: self name.
	^ g resolved first name ~= self currentVersionInfo name
]

{ #category : #'*GT-Metaceller-Model' }
MetacelloPackageSpec >> needsSaving [
	| copy |
	copy := self workingCopy.
	copy isNil ifTrue: [^ false ].
	^ copy needsSaving
]
