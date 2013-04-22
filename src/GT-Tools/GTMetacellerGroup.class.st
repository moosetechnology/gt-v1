Class {
	#name : #GTMetacellerGroup,
	#superclass : #Object,
	#instVars : [
		'version',
		'group',
		'children'
	],
	#category : #'GT-Tools-Metaceller'
}

{ #category : #'instance creation' }
GTMetacellerGroup class >> on: aVersion group: aGroup [
	^self basicNew
		initialize: aVersion group: aGroup;
		yourself
]

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
					ifNotNil: [ (black includes: package) ifFalse: [ gray add: package ] ] ] ] ].
	^black
]

{ #category : #accessing }
GTMetacellerGroup >> children [
	^children := self buildChildren
"	^children ifNil: [ children := self buildChildren ]"
]

{ #category : #accessing }
GTMetacellerGroup >> file [
	^self group file
]

{ #category : #accessing }
GTMetacellerGroup >> group [
	^ group
]

{ #category : #initialization }
GTMetacellerGroup >> initialize: aVersion group: aGroup [
	self initialize.
	version := aVersion.
	group := aGroup
]

{ #category : #accessing }
GTMetacellerGroup >> isPackage: aSpec [ 
	^aSpec isKindOf: MetacelloPackageSpec
]

{ #category : #accessing }
GTMetacellerGroup >> isPackageLoaded [
	^self group isPackageLoaded
]

{ #category : #accessing }
GTMetacellerGroup >> label [
	^self group label
]

{ #category : #accessing }
GTMetacellerGroup >> version [
	^ version
]
