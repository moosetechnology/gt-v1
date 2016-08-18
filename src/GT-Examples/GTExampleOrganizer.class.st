Class {
	#name : #GTExampleOrganizer,
	#superclass : #Object,
	#instVars : [
		'theNonMetaClassExamples',
		'theMetaClassExamples',
		'results',
		'systemAnnouncements',
		'monticelloAnnouncements'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'GT-Examples-Organization'
}

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
	
	self restart
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

{ #category : #'private-maintenance' }
GTExampleOrganizer >> addExamplesOfClass: aClassName for: announcement [
	(Smalltalk classNamed: aClassName asString) ifNotNil: [ :class | 
		announcement addExamples: class theNonMetaClass gtExamples ]
]

{ #category : #private }
GTExampleOrganizer >> announcer [
	^ SystemAnnouncer uniqueInstance weak
]

{ #category : #public }
GTExampleOrganizer >> browserEnvironment [
	| environment |
	environment := RBSelectorEnvironment new.
	self examplesDo: [ :className :selector :example |
		environment addClass: example methodClass selector: example selector ].
	^ environment
]

{ #category : #'private-events' }
GTExampleOrganizer >> categoryRemoved: anAnnouncement [
	self withoutExceptionsDo: [ 
		self with: GTExamplesModifiedAnnouncement announcement: anAnnouncement do: [ :ann |
			self examplesDo: [ :example | ann removeExample: example ].
			self reset.
			self examplesDo: [ :example | ann addExample: example ]. ] ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> classRemoved: anAnnouncement [
	self withoutExceptionsDo: [ 
		self resetStubs.
		self with: GTExamplesModifiedAnnouncement announcement: anAnnouncement do: [ :ann |
			self removeExamplesOfClass: anAnnouncement classRemoved theNonMetaClass name for: ann ] ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> classRenamed: anAnnouncement [
	self withoutExceptionsDo: [ 
		self resetStubs.
		self with: GTExamplesModifiedAnnouncement announcement: anAnnouncement do: [ :ann |
			self removeExamplesOfClass: anAnnouncement oldName for: ann.
			self addExamplesOfClass: anAnnouncement newName for: ann ] ]
]

{ #category : #TODO }
GTExampleOrganizer >> exampleAt: aCompiledMethod [
	^ self exampleAt: aCompiledMethod ifAbsent: [ aCompiledMethod gtExample ]
]

{ #category : #TODO }
GTExampleOrganizer >> exampleAt: aCompiledMethod ifAbsent: aBlock [
	^ self exampleAtClass: aCompiledMethod methodClass selector: aCompiledMethod selector ifAbsent: aBlock
]

{ #category : #TODO }
GTExampleOrganizer >> exampleAt: aCompiledMethod ifAbsentPut: aBlock [
	^ self exampleAtClass: aCompiledMethod methodClass selector: aCompiledMethod selector ifAbsentPut: aBlock
]

{ #category : #private }
GTExampleOrganizer >> exampleAtClass: class selector: selector ifAbsent: aBlock [
	^ ((class isMeta 
		ifTrue: [ theMetaClassExamples ]
		ifFalse: [ theNonMetaClassExamples ]) 
			at: class theNonMetaClass name
			ifAbsentPut: [ WeakIdentityKeyDictionary new: 100 ])
				at: selector 
				ifAbsent: aBlock
]

{ #category : #private }
GTExampleOrganizer >> exampleAtClass: class selector: selector ifAbsentPut: aBlock [
	| methodDict |
	methodDict := (class isMeta 
		ifTrue: [ theMetaClassExamples ]
		ifFalse: [ theNonMetaClassExamples ]) 
			at: class theNonMetaClass name
			ifAbsentPut: [ WeakIdentityKeyDictionary new: 100 ].
	^ methodDict 
		at: selector 
		ifAbsent: [ aBlock value ifNotNil: [ :example | methodDict at: selector put: example ] ]
]

{ #category : #enumeration }
GTExampleOrganizer >> examplesCollect: aBlock [
	| examples |
	examples := OrderedCollection new: 1000.
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
	examples := OrderedCollection new: 1000.
	self examplesDo: [ :class :selector :example | 
		(aBlock value: example) ifTrue: [ examples add: example ] ].
	^ examples
]

{ #category : #enumeration }
GTExampleOrganizer >> examplesSelect: aBlock1 thenDo: aBlock2 [
	| examples |
	examples := OrderedCollection new: 1000.
	self examplesDo: [ :example |
		(aBlock2 value: example) ifTrue: [ 
			examples add: example.
			aBlock1 value: example ] ].
	^ examples
]

{ #category : #public }
GTExampleOrganizer >> gtExamplesContained [
	^ self examplesCollect: [ :each | each ]
]

{ #category : #ui }
GTExampleOrganizer >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'Examples';
		filter: GTNullFilter item: [ :filter :context | 
			self examplesDo: [ :cn :s :example | filter value: example ] ]
]

{ #category : #'private-maintenance' }
GTExampleOrganizer >> handleGTReservedMethod: aCompiledMethod for: announcement [
	aCompiledMethod isGTReservedMethod ifFalse: [ ^ self ].
	self removeExamplesOfClass: aCompiledMethod methodClass theNonMetaClass name for: announcement
]

{ #category : #initializing }
GTExampleOrganizer >> initialize [
	super initialize.
	
	theNonMetaClassExamples := WeakIdentityKeyDictionary new: 10000.
	theMetaClassExamples := WeakIdentityKeyDictionary new: 10000.
	results := LRUCache new
		maximumWeight: 20;
		yourself
]

{ #category : #'private-events' }
GTExampleOrganizer >> loadStarted: anAnnouncement [
	self withoutExceptionsDo: [
		self stopSystemAnnouncements.
		self reset ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> loadStopped: anAnnouncement [
	self withoutExceptionsDo: [ 
		self startSystemAnnouncements.
		self reinitialize ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodAdded: anAnnouncement [
	self withoutExceptionsDo: [ 
		self with: GTExamplesModifiedAnnouncement announcement: anAnnouncement do: [ :ann |
			self handleGTReservedMethod: anAnnouncement method for: ann.
			self removeExamplesOfMethod: anAnnouncement method for: ann.
			ann addExample: anAnnouncement method gtExample ] ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodModified: anAnnouncement [
	self withoutExceptionsDo: [ 
		self resetStubs.
		self with: GTExamplesModifiedAnnouncement announcement: anAnnouncement do: [ :ann |
			self handleGTReservedMethod: anAnnouncement oldMethod for: ann.
			self handleGTReservedMethod: anAnnouncement method for: ann.
			self removeExamplesOfMethod: anAnnouncement oldMethod for: ann.
			self removeExamplesOfMethod: anAnnouncement method for: ann.
			ann addExample: anAnnouncement method gtExample ] ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodRemoved: anAnnouncement [
	self withoutExceptionsDo: [ 
		self resetStubs.
		self with: GTExamplesModifiedAnnouncement announcement: anAnnouncement do: [ :ann |
			self handleGTReservedMethod: anAnnouncement method for: ann.
			self removeExamplesOfMethod: anAnnouncement method for: ann ] ]
]

{ #category : #public }
GTExampleOrganizer >> reinitialize [
	SmalltalkImage current gtExamplesContained
]

{ #category : #'private-maintenance' }
GTExampleOrganizer >> removeExamplesOfClass: aClassName for: announcement [
	announcement removeExamples: (theNonMetaClassExamples removeKey: aClassName ifAbsent: [ nil ]).
	announcement removeExamples: (theMetaClassExamples removeKey: aClassName	ifAbsent: [ nil ])
]

{ #category : #'private-maintenance' }
GTExampleOrganizer >> removeExamplesOfMethod: aCompiledMethod for: announcement [
	self removeKey: aCompiledMethod methodClass theNonMetaClass name from: theNonMetaClassExamples thenDo: [ :methodDict |
		announcement removeExample: (methodDict removeKey: aCompiledMethod selector ifAbsent: [ nil ]) ].
	self removeKey: aCompiledMethod methodClass theNonMetaClass name from: theMetaClassExamples thenDo: [ :methodDict |
		announcement removeExample: (methodDict removeKey: aCompiledMethod selector ifAbsent: [ nil ]) ]
]

{ #category : #'private-maintenance' }
GTExampleOrganizer >> removeKey: aKey from: aDictionary thenDo: aBlock [
	aBlock value: (aDictionary removeKey: aKey ifAbsent: [ ^ nil ])
]

{ #category : #public }
GTExampleOrganizer >> reset [
	self initialize
]

{ #category : #'private-events' }
GTExampleOrganizer >> resetStubs [
	[ GTAbstractExampleObject allSubInstancesDo: [ :each | each resetStub ] ] 
		forkAt: 30
		named: 'GTExampleOrganizer >> #resetStubs'
]

{ #category : #public }
GTExampleOrganizer >> restart [
	self stopThoroughly.
	self start.
]

{ #category : #TODO }
GTExampleOrganizer >> resultAt: aGTExample ifAbsent: aBlock [
	^ results at: { aGTExample methodClass. aGTExample selector } ifAbsent: aBlock
]

{ #category : #TODO }
GTExampleOrganizer >> resultAt: aGTExample put: aGTExampleResult [
	GTAbstractExampleNautilusActionButton methodUpdated: aGTExample method with: aGTExampleResult.
	^ results at: { aGTExample methodClass. aGTExample selector } put: aGTExampleResult
]

{ #category : #public }
GTExampleOrganizer >> start [
	self startMonticelloAnnouncements.
	self startSystemAnnouncements
]

{ #category : #private }
GTExampleOrganizer >> startMonticelloAnnouncements [
	monticelloAnnouncements == true ifTrue: [ ^ self ].
	SystemAnnouncer uniqueInstance weak
		when: MCVersionLoaderStarted send: #loadStarted: to: self;
		when: MCVersionLoaderStopped send: #loadStopped: to: self.
	monticelloAnnouncements := true
]

{ #category : #private }
GTExampleOrganizer >> startSystemAnnouncements [
	systemAnnouncements == true ifTrue: [ ^ self ].
	SystemAnnouncer uniqueInstance weak
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
	SystemAnnouncer uniqueInstance
		unsubscribe: MCVersionLoaderStarted thoroughlyFor: self;
		unsubscribe: MCVersionLoaderStopped thoroughlyFor: self.
	monticelloAnnouncements := false
]

{ #category : #private }
GTExampleOrganizer >> stopSystemAnnouncements [
	SystemAnnouncer uniqueInstance
		unsubscribe: MethodAdded thoroughlyFor: self;
		unsubscribe: MethodModified thoroughlyFor: self;
		unsubscribe: MethodRemoved thoroughlyFor: self;
		unsubscribe: ClassRemoved thoroughlyFor: self;
		unsubscribe: ClassRenamed thoroughlyFor: self;
		unsubscribe: CategoryRemoved thoroughlyFor: self.
	systemAnnouncements := false
]

{ #category : #public }
GTExampleOrganizer >> stopThoroughly [
	self stop.
	
	Announcer allSubInstances do: [ :each | each unsubscribeThoroughly: self ]
]

{ #category : #private }
GTExampleOrganizer >> with: aClass announcement: announcement do: aBlock [
	| wrappedAnnouncement |
	wrappedAnnouncement := aClass new
		announcement: announcement;
		yourself.
	aBlock value: wrappedAnnouncement.
	wrappedAnnouncement isEmpty ifTrue: [ ^ self ].
	SystemAnnouncer uniqueInstance announce: wrappedAnnouncement
]

{ #category : #private }
GTExampleOrganizer >> withoutExceptionsDo: aBlock [
	[ aBlock value ]
		on: Error
		do: [ :exception | " we should not ignore it, but try to continue " ]
]
