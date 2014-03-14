Class {
	#name : #GTMetacellerModel,
	#superclass : #Object,
	#instVars : [
		'configs',
		'sortedCache',
		'announcer',
		'test'
	],
	#classInstVars : [
		'default'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #singleton }
GTMetacellerModel class >> default [
	^default ifNil: [ default := self new ]
]

{ #category : #singleton }
GTMetacellerModel class >> reset [
	default := nil
]

{ #category : #accessing }
GTMetacellerModel >> announce: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : #accessing }
GTMetacellerModel >> announcer [
	^announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #initialization }
GTMetacellerModel >> buildConfigs [
	| retVal |
	retVal := Dictionary new.
	Object subclasses do: [:each | (self isMetacelloConfig: each)
		ifTrue: [ retVal at: each put: (GTMetacellerConfiguration on: each) ] ].
	^retVal
]

{ #category : #initialization }
GTMetacellerModel >> buildSortedCache [
	^ (self configs values sort: [:a :b | a displayString < b displayString])
]

{ #category : #events }
GTMetacellerModel >> classRemoved: anAnnouncement [
	(self isMetacelloConfig: anAnnouncement classRemoved) ifTrue: [ 
		| config |
		config := configs at: anAnnouncement classRemoved ifAbsent: [ nil ].
		configs removeKey: anAnnouncement classRemoved ifAbsent: [ ].
		sortedCache := nil.
		self announce: (GTConfigLoaded on: config) ]
]

{ #category : #events }
GTMetacellerModel >> classRenamed: anAnnouncement [
	(self isMetacelloConfig: anAnnouncement classRenamed) ifTrue: [ 
		Transcript log: '...'.
		(configs at: anAnnouncement classRenamed ifAbsent: [ nil ])
			ifNotNilDo: [ :config | config reset. sortedCache := nil ].
		self announce: (GTConfigLoaded on: (configs at: anAnnouncement classRenamed)) ]
]

{ #category : #accessing }
GTMetacellerModel >> configs [
	^configs ifNil: [ configs := self buildConfigs ]
]

{ #category : #accessing }
GTMetacellerModel >> configurations [
	^self sortedCache
]

{ #category : #initialization }
GTMetacellerModel >> initialize [
	super initialize.
	self register
]

{ #category : #testing }
GTMetacellerModel >> isMetacelloConfig: anObject [
	(anObject respondsTo: #isMetacelloConfig) ifTrue: [  
		(anObject className beginsWith: 'Metacello') ifFalse: [ ^anObject isMetacelloConfig ] ].
	^false
]

{ #category : #events }
GTMetacellerModel >> methodChanged: anAnnouncement [
	(self isMetacelloConfig: anAnnouncement methodClass) ifTrue: [
		(configs includesKey: anAnnouncement methodClass)
			ifTrue: [ (configs at: anAnnouncement methodClass) reset.
				self announce: (GTConfigChanged on: (configs at: anAnnouncement methodClass)) ]
			ifFalse: [
				configs at: anAnnouncement methodClass
					put: (GTMetacellerConfiguration on: anAnnouncement methodClass).
				sortedCache := nil.
				self announce: (GTConfigLoaded on: (configs at: anAnnouncement methodClass)) ] ]
		ifFalse: [
			(configs includesKey: anAnnouncement methodClass) ifTrue: [ 
				| config |
				config := configs at: anAnnouncement methodClass.
				configs removeKey: anAnnouncement methodClass.
				sortedCache := nil.
				self announce: (GTConfigLoaded on: config) ] ]
]

{ #category : #events }
GTMetacellerModel >> register [
	SystemAnnouncer uniqueInstance weak
		on: ClassRemoved send: #classRemoved: to: self;
		on: ClassRenamed send: #classRenamed: to: self;
		on: MethodAdded send: #methodChanged: to: self;
		on: MethodModified send: #methodChanged: to: self;
		on: MethodRemoved send: #methodChanged: to: self;
		yourself
]

{ #category : #test }
GTMetacellerModel >> resetTest [
	test := nil
]

{ #category : #accessing }
GTMetacellerModel >> sortedCache [
	^sortedCache ifNil: [ sortedCache := self buildSortedCache ]
]

{ #category : #accessing }
GTMetacellerModel >> test [
	^test ifNil: [ test := OrderedCollection new ]
]
