Extension { #name : #MetacelloPackageSpec }

{ #category : #'*gt-metaceller-model' }
MetacelloPackageSpec >> hasNewerVersionsFrom: version [
	| g |
	g := Gofer new.
	version spec repositories list do: [:each | g url: each name ].
	g package: self name.
	^ g resolved first name ~= self currentVersionInfo name
]

{ #category : #'*gt-metaceller-model' }
MetacelloPackageSpec >> needsSaving [
	| copy |
	copy := self workingCopy.
	copy isNil ifTrue: [^ false ].
	^ copy needsSaving
]
