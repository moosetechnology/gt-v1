Class {
	#name : #GTExampleOrganizer,
	#superclass : #Object,
	#instVars : [
		'theNonMetaClassExamples',
		'theMetaClassExamples',
		'systemAnnouncements',
		'monticelloAnnouncements'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'GT-Examples-Core'
}

{ #category : #examples }
GTExampleOrganizer class >> gtExampleInstance [
	<gtExample>
	<label: 'An instance of an example organizer'>
	
	^ GTExampleOrganizer instance
]

{ #category : #public }
GTExampleOrganizer class >> instance [
	^ instance ifNil: [ instance := self basicNew initialize start ]
]

{ #category : #public }
GTExampleOrganizer class >> new [
	self shouldNotImplement
]

{ #category : #private }
GTExampleOrganizer class >> registerInterestToSystemAnnouncement [
	<systemEventRegistration>
	
	self instance 
		stopSystemAnnouncements;
		stopMonticelloAnnouncements;
		startSystemAnnouncements;
		startMonticelloAnnouncements.
]

{ #category : #public }
GTExampleOrganizer class >> reset [
	instance ifNotNil: [ instance reset ].
	instance := nil
]

{ #category : #public }
GTExampleOrganizer class >> restart [
	self stop.
	self start.
]

{ #category : #public }
GTExampleOrganizer class >> start [
	self instance start
]

{ #category : #public }
GTExampleOrganizer class >> stop [
	instance ifNotNil: [ instance stopThoroughly ].
	self reset
]

{ #category : #private }
GTExampleOrganizer >> announcer [
	^ SystemAnnouncer uniqueInstance weak
]

{ #category : #'private-events' }
GTExampleOrganizer >> categoryRemoved: anAnnouncement [
	self withoutExceptionsDo: [ 
		self reset; reinitialize ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> classRemoved: anAnnouncement [
	self withoutExceptionsDo: [ 
		theNonMetaClassExamples removeKey: anAnnouncement classRemoved theNonMetaClass name ifAbsent: [  ].
		theMetaClassExamples removeKey: anAnnouncement classRemoved theNonMetaClass name ifAbsent: [  ] ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> classRenamed: anAnnouncement [
	self withoutExceptionsDo: [ 
		theNonMetaClassExamples removeKey: anAnnouncement oldName asSymbol ifAbsent: [  ].
		theMetaClassExamples removeKey: anAnnouncement oldName asSymbol ifAbsent: [  ].
		(Smalltalk classNamed: anAnnouncement newName) ifNotNil: [ :class | class gtExamples ] ]
]

{ #category : #accessing }
GTExampleOrganizer >> exampleAt: aCompiledMethod ifAbsentPut: aBlock [
	^ self exampleAtClass: aCompiledMethod methodClass selector: aCompiledMethod selector ifAbsentPut: aBlock
]

{ #category : #private }
GTExampleOrganizer >> exampleAtClass: class selector: selector ifAbsentPut: aBlock [
	^ ((class isMeta 
		ifTrue: [ theMetaClassExamples ]
		ifFalse: [ theNonMetaClassExamples ]) 
			at: class name
			ifAbsentPut: [ WeakIdentityKeyDictionary new ]) 
				at: selector 
				ifAbsentPut: aBlock
]

{ #category : #enumeration }
GTExampleOrganizer >> examplesCollect: aBlock [
	| examples |
	examples := OrderedCollection new.
	self examplesDo: [ :class :method :example | 
		examples add: (aBlock value: example) ].
	^ examples
]

{ #category : #enumeration }
GTExampleOrganizer >> examplesDetect: aBlock [
	self examplesDo: [ :class :selector :example | 
		(aBlock value: example) ifTrue: [ ^ example ] ].
	^ nil
]

{ #category : #enumeration }
GTExampleOrganizer >> examplesDo: aBlock [
	theNonMetaClassExamples keysAndValuesDo: [ :className :methodDict |
		methodDict keysAndValuesDo: [ :selector :example | 
			aBlock value: className value: selector value: example ] ].
	theMetaClassExamples keysAndValuesDo: [ :className :methodDict |
		methodDict keysAndValuesDo: [ :selector :example | 
			aBlock value: className value: selector value: example ] ]
]

{ #category : #enumeration }
GTExampleOrganizer >> examplesReject: aBlock [
	^ self examplesSelect: [ :example | (aBlock value: example) not ]
]

{ #category : #enumeration }
GTExampleOrganizer >> examplesSelect: aBlock [
	| examples |
	examples := OrderedCollection new.
	self examplesDo: [ :class :selector :example | 
		(aBlock value: example) ifTrue: [ examples add: example ] ].
	^ examples
]

{ #category : #ui }
GTExampleOrganizer >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'Examples';
		allCandidates: [ Smalltalk gtExamplesContained ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #initializing }
GTExampleOrganizer >> initialize [
	super initialize.
	
	theNonMetaClassExamples := WeakIdentityKeyDictionary new.
	theMetaClassExamples := WeakIdentityKeyDictionary new.
]

{ #category : #'private-events' }
GTExampleOrganizer >> loadStarted: anAnnouncement [
	self withoutExceptionsDo: [
		self stopSystemAnnouncements ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> loadStopped: anAnnouncement [
	self withoutExceptionsDo: [ 
		self startSystemAnnouncements ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodAdded: anAnnouncement [
	self withoutExceptionsDo: [ 
		anAnnouncement method gtExample ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodModified: anAnnouncement [
	self withoutExceptionsDo: [ 
		theNonMetaClassExamples removeKey: anAnnouncement classRemoved theNonMetaClass name thenDo: [ :methodDict |
			methodDict removeKey: anAnnouncement method selector ifAbsent: [  ] ].
		theMetaClassExamples removeKey: anAnnouncement classRemoved theNonMetaClass name thenDo: [ :methodDict |
			methodDict removeKey: anAnnouncement method selector ifAbsent: [  ] ].
		anAnnouncement method gtExample ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodRemoved: anAnnouncement [
	self withoutExceptionsDo: [ 
		theNonMetaClassExamples removeKey: anAnnouncement oldMethod methodClass theNonMetaClass name thenDo: [ :methodDict |
			methodDict removeKey: anAnnouncement oldMethod selector ifAbsent: [  ] ].
		theMetaClassExamples removeKey: anAnnouncement oldMethod methodClass theNonMetaClass name thenDo: [ :methodDict |
			methodDict removeKey: anAnnouncement oldMethod selector ifAbsent: [  ] ] ]
]

{ #category : #public }
GTExampleOrganizer >> reinitialize [
	SmalltalkImage current gtExamplesContained
]

{ #category : #public }
GTExampleOrganizer >> reset [
	self initialize
]

{ #category : #public }
GTExampleOrganizer >> restart [
	self stopThoroughly.
	self start.
]

{ #category : #public }
GTExampleOrganizer >> start [
	self startMonticelloAnnouncements.
	self startSystemAnnouncements
]

{ #category : #private }
GTExampleOrganizer >> startMonticelloAnnouncements [
	monticelloAnnouncements == true ifTrue: [ ^ self ].
	self announcer
		when: MCVersionLoaderStarted send: #loadStarted: to: self;
		when: MCVersionLoaderStopped send: #loadStopped: to: self.
	monticelloAnnouncements := true
]

{ #category : #private }
GTExampleOrganizer >> startSystemAnnouncements [
	systemAnnouncements == true ifTrue: [ ^ self ].
	self announcer
		when: MethodAdded send: #methodAdded: to: self;
		when: MethodModified send: #methodModified: to: self;
		when: MethodRemoved send: #methodRemoved: to: self;
		when: ClassRemoved send: #classRemoved: to: self;
		when: ClassRenamed send: #classRenamed: to: self;
		when: CategoryRemoved send: #categoryRemoved: to: self.
	systemAnnouncements := true
]

{ #category : #public }
GTExampleOrganizer >> stop [
	self stopMonticelloAnnouncements.
	self stopSystemAnnouncements
]

{ #category : #private }
GTExampleOrganizer >> stopMonticelloAnnouncements [
	self announcer 
		unsubscribe: MCVersionLoaderStarted thoroughlyfor: self;
		unsubscribe: MCVersionLoaderStopped thoroughlyfor: self.
	monticelloAnnouncements := false
]

{ #category : #private }
GTExampleOrganizer >> stopSystemAnnouncements [
	self announcer 
		unsubscribe: MethodAdded thoroughlyfor: self;
		unsubscribe: MethodModified thoroughlyfor: self;
		unsubscribe: MethodRemoved thoroughlyfor: self;
		unsubscribe: ClassRemoved thoroughlyfor: self;
		unsubscribe: ClassRenamed thoroughlyfor: self;
		unsubscribe: CategoryRemoved thoroughlyfor: self.
	systemAnnouncements := false
]

{ #category : #public }
GTExampleOrganizer >> stopThoroughly [
	self stop.
	
	Announcer allSubInstances do: [ :each | each unsubscribeThoroughly: self ]
]

{ #category : #private }
GTExampleOrganizer >> withoutExceptionsDo: aBlock [
	[ aBlock value ]
		on: Error
		do: [ :exception | " we should not ignore it, but try to continue " ]
]
