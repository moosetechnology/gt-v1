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

{ #category : #'code generation' }
GTMetacellerSpec >> streamSpecOn: aStream indent: anIndent specName: aSpecName [
	| needsWith needsWithBlock repositories |
	repositories := self repositories.
	needsWithBlock := repositories notEmpty.
	self specAccessors allButFirstDo: [ :each | needsWithBlock := needsWithBlock or: [ 
			(self dataFor: each) notNil ] ].
	needsWith := needsWithBlock not and: [ (self dataFor: self specAccessors first) notNil ].
	aStream cr; tab: anIndent; nextPutAll: self itemKindString; nextPutAll: ': '.
	self itemName asCodeStringOn: aStream.
	needsWith ifTrue: [
		aStream nextPutAll: ' with: '. 
		(self dataFor: self specAccessors first) asCodeStringOn: aStream ].
	needsWithBlock
		ifTrue: [
			aStream nextPutAll: ' with: ['; cr.
			aStream tab: anIndent +1; nextPutAll: aSpecName.
			self specAccessors do: [ :each |
				(self dataFor: each) ifNotNilDo: [ :data |
					aStream cr; tab: anIndent +2; nextPutAll: each asString; nextPutAll: ': '.
					data asCodeStringOn: aStream.
					aStream nextPut: $; ] ].
			repositories do: [ :repo |
				aStream cr; tab: anIndent +2; nextPutAll: 'repository: '.
				repo asCodeStringOn: aStream.
				aStream nextPut: $; ].
			aStream cr; tab: anIndent +2; nextPutAll: 'yourself ];' ]
		ifFalse: [ aStream nextPut: $; ]
]
