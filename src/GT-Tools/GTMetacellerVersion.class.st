Class {
	#name : #GTMetacellerVersion,
	#superclass : #Object,
	#instVars : [
		'method',
		'version',
		'configuration'
	],
	#category : #'GT-Tools-Metaceller'
}

{ #category : #conveniance }
GTMetacellerVersion class >> allMethodsForConfig: aConfiguration [
	^aConfiguration methods collect: [ :each |
		self on: aConfiguration method: each ]
]

{ #category : #testing }
GTMetacellerVersion class >> isValidVersion: aVersion [
	aVersion pragmas do: [ :each |
		(each key beginsWith: 'version') ifTrue: [  ^true ] ].
	^false
]

{ #category : #actions }
GTMetacellerVersion class >> load: aString [ 
	self version ifNotNil: [ self version load: aString ]
]

{ #category : #'instance creation' }
GTMetacellerVersion class >> on: aConfiguration method: aMethod [
	^self basicNew
		initialize: aConfiguration method: aMethod;
		yourself
]

{ #category : #conveniance }
GTMetacellerVersion class >> versionsForConfig: aConfiguration [
	^(aConfiguration methods
		select: [ :each | self isValidVersion: each ]
		thenCollect: [ :each | self on: aConfiguration method: each ]) 
			asSortedCollection: [ :a :b | a name > b name ]
]

{ #category : #accessing }
GTMetacellerVersion >> configuration [
	^ configuration
]

{ #category : #accessing }
GTMetacellerVersion >> configuration: anObject [
	configuration := anObject
]

{ #category : #accessing }
GTMetacellerVersion >> determineVersion [
	self method pragmas do: [ :each |
		(each key beginsWith: 'version') ifTrue: [ ^self configuration project version: (each arguments first) ] ].
	^nil
]

{ #category : #actions }
GTMetacellerVersion >> fetch [
	self version ifNotNil: [ self version fetch ]
]

{ #category : #accessing }
GTMetacellerVersion >> groups [
	self version ifNotNil: [ ^self version groups ].
	^#()
]

{ #category : #testing }
GTMetacellerVersion >> initialize: aConfiguration method: aMethod [
	self initialize.
	method := aMethod.
	configuration := aConfiguration
]

{ #category : #actions }
GTMetacellerVersion >> load [
	self version ifNotNil: [ self version load ]
]

{ #category : #accessing }
GTMetacellerVersion >> method [
	^ method
]

{ #category : #accessing }
GTMetacellerVersion >> method: anObject [
	method := anObject
]

{ #category : #accessing }
GTMetacellerVersion >> methodCategory [
	^self method category
]

{ #category : #accessing }
GTMetacellerVersion >> methodClass [
	^self configuration
]

{ #category : #accessing }
GTMetacellerVersion >> methodString [
	^self method asString
]

{ #category : #testing }
GTMetacellerVersion >> name [
	method pragmas do: [  :each |
		(each key beginsWith: 'version') ifTrue: [ ^each arguments first ] ].
	^method selector
]

{ #category : #accessing }
GTMetacellerVersion >> packages [
	self version ifNil: [ ^#() ].
	^self version packages
]

{ #category : #accessing }
GTMetacellerVersion >> packagesForSpecNamed: aVersionString [ 
	self version ifNotNil: [ ^self version packagesForSpecNamed: aVersionString ].
	^#()
]

{ #category : #accessing }
GTMetacellerVersion >> projects [
	self version ifNil: [ ^#() ].
	^self version projects
]

{ #category : #accessing }
GTMetacellerVersion >> selector [
	^self method selector
]

{ #category : #accessing }
GTMetacellerVersion >> spec [
	self version ifNotNil: [ ^self version spec ].
	^nil
]

{ #category : #accessing }
GTMetacellerVersion >> textLabel [
	self version ifNil: [ ^Text string: self name attribute: TextColor red ].
	^self name
]

{ #category : #accessing }
GTMetacellerVersion >> version [
	^ version ifNil: [ version := self determineVersion ]
]

{ #category : #accessing }
GTMetacellerVersion >> version: anObject [
	version := anObject
]
