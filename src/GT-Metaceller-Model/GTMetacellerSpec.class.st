Class {
	#name : #GTMetacellerSpec,
	#superclass : #Object,
	#category : #'GT-Metaceller-Model'
}

{ #category : #'code generation' }
GTMetacellerSpec >> differenceWith: anItem [ 
	^self subclassResponsibility
]

{ #category : #'code generation' }
GTMetacellerSpec >> itemKindString [
	^self subclassResponsibility
]

{ #category : #accessing }
GTMetacellerSpec >> removed [
	^false
]

{ #category : #'code generation' }
GTMetacellerSpec >> specAccessors [
	^self subclassResponsibility
]

{ #category : #'code generation' }
GTMetacellerSpec >> streamSpecOn: aStream specName: aSpecName [
	| needsWith needsWithBlock repositories |
	self removed ifTrue: [ ^self ].
	repositories := self repositories.
	needsWithBlock := repositories notEmpty.
	self specAccessors allButFirstDo: [ :each | needsWithBlock := needsWithBlock or: [ 
			(self dataFor: each) notNil ] ].
	needsWith := needsWithBlock not and: [ (self dataFor: self specAccessors first) notNil ].
	aStream currentOpenTag assign: self itemKindString value: self itemName.
	needsWith ifTrue: [
		aStream currentOpenTag withValue: (self dataFor: self specAccessors first) ].
	needsWithBlock ifTrue: [
		aStream currentOpenTag withBlock: [
			| cascade |
			cascade := aStream startCascade: aSpecName.
			self specAccessors do: [ :each |
				(self dataFor: each) ifNotNilDo: [ :data |
					cascade assign: each value: data ] ].
			repositories do: [ :repo |
				cascade assign: 'repository' value: repo ] ] ]
]
