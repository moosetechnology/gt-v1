Class {
	#name : #GTMetacellerGroup,
	#superclass : #GTMetacellerItem,
	#instVars : [
		'children'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #accessing }
GTMetacellerGroup >> buildChildren [
	| retVal |
	retVal := OrderedCollection new.
	self addAll: self group name to: retVal version: self version.
	^retVal collect: [ :each | self wrapperFor: each version: self version ]

]

{ #category : #accessing }
GTMetacellerGroup >> children [
	^children ifNil: [ children := self buildChildren ]
]

{ #category : #'code generation' }
GTMetacellerGroup >> defaultItemKindString [
	^'group'
]

{ #category : #accessing }
GTMetacellerGroup >> file [
	^self group file
]

{ #category : #accessing }
GTMetacellerGroup >> group [
	^self referenceSpec
]

{ #category : #testing }
GTMetacellerGroup >> hasErrors [
	^super hasErrors or: [ self children contains: [ :each | each hasErrors ] ]
]

{ #category : #testing }
GTMetacellerGroup >> hasWarnings [
	^super hasWarnings or: [ self children contains: [ :each | each hasWarnings ] ]
]

{ #category : #testing }
GTMetacellerGroup >> isCompatibleWith: anItem [
	^false
]

{ #category : #testing }
GTMetacellerGroup >> isGroup [
	^true
]

{ #category : #testing }
GTMetacellerGroup >> isPackageLoaded [
	^self group isPackageLoaded
]

{ #category : #accessing }
GTMetacellerGroup >> label [
	^self group label
]

{ #category : #display }
GTMetacellerGroup >> labelAsText [
	^Text string: self label attribute: TextEmphasis italic
]

{ #category : #'code generation' }
GTMetacellerGroup >> specAccessors [
	^#( includes )
]

{ #category : #actions }
GTMetacellerGroup >> testValid [
	self children do: [ :each | each testValid ]
]

{ #category : #actions }
GTMetacellerGroup >> validate [
	self children do: [ :each | each validate ]
]

{ #category : #tool }
GTMetacellerGroup >> wrapperFor: anItem version: aVersion [
	| retVal |
	retVal := super wrapperFor: anItem version: aVersion.
	retVal parentTrace: self.
	^retVal
]
