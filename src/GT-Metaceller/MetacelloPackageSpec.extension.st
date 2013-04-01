Extension { #name : #MetacelloPackageSpec }

{ #category : #'*gt-metaceller' }
MetacelloPackageSpec >> hasNewerVersionsFrom: version [
	| g |
	g := Gofer new.
	version spec repositories list do: [:each | g url: each name ].
	g package: self name.
	^ g resolved first name ~= self currentVersionInfo name
]

{ #category : #'*gt-metaceller' }
MetacelloPackageSpec >> labelAsText [	
	^ self needsSaving
			ifTrue: [ Text string: self file attribute: TextColor blue] 
			ifFalse: [ Text fromString: self file ]
]

{ #category : #'*gt-metaceller' }
MetacelloPackageSpec >> needsSaving [
	| copy |
	copy := self workingCopy.
	copy isNil ifTrue: [^ false ].
	^ copy needsSaving
]
