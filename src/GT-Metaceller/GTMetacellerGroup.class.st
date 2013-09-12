Class {
	#name : #GTMetacellerGroup,
	#superclass : #GTMetacellerItem,
	#instVars : [
		'children'
	],
	#category : #'GT-Metaceller'
}

{ #category : #accessing }
GTMetacellerGroup >> buildChildren [
	| black gray |
	gray := (self version packagesForSpecNamed: self group name) asSet.
	black := OrderedCollection new.
	[ gray notEmpty ] whileTrue: [ 
		| spec |
		spec := gray anyOne.
		gray remove: spec.
		black add: spec.
		(self isPackage: spec) ifTrue: [ 
			spec requires do: [ :reqString |
				| package |
				package := self version packageNamed: reqString ifAbsent: [ nil ].
				package 
					ifNil: [ (self version packagesForSpecNamed: reqString) do: [ :each |
						(black includes: each) ifFalse: [ gray add: each ] ] ]
					ifNotNil: [ (black includes: package) ifFalse: [ gray add: package ] ] ].
			spec includes do: [ :inclString |
				| package |
				package := self version packageNamed: inclString ifAbsent: [ nil ].
				package 
					ifNil: [ (self version packagesForSpecNamed: inclString) do: [ :each |
						(black includes: each) ifFalse: [ gray add: each ] ] ]
					ifNotNil: [ (black includes: package) ifFalse: [ gray add: package ] ] ] ] ].
	^black
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
