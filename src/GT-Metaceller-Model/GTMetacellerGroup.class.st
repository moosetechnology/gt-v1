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

{ #category : #accessing }
GTMetacellerGroup >> file [
	^self group file
]

{ #category : #accessing }
GTMetacellerGroup >> group [
	^self referenceSpec
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
