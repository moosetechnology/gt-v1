Class {
	#name : #GTExampleOrganizer,
	#superclass : #Object,
	#instVars : [
		'running',
		'examples'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'GT-Inspector-Examples-Utils'
}

{ #category : #public }
GTExampleOrganizer class >> instance [
	^ instance ifNil: [ instance := self new start ]
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
	instance ifNotNil: [ instance stop ].
	instance := nil
]

{ #category : #accessing }
GTExampleOrganizer >> atMethod: aCompiledMethod ifAbsentPut: aBlock [
	<todo: '#theNonMetaClass is not good'>
	^ (examples at: aCompiledMethod methodClass theNonMetaClass name ifAbsentPut: [ IdentityDictionary new ]) 
		at: aCompiledMethod selector 
		ifAbsentPut: aBlock
]

{ #category : #'private-events' }
GTExampleOrganizer >> categoryRemoved: anAnnouncement [
	self withCleanupDo: [ 
		examples keys do: [ :key |
			(Smalltalk classNamed: key) ifNil: [ 
				(examples removeKey: key ifAbsent: [ nil ]) ifNotNil: [ :dict | 
					dict do: #detachFromSystem ] ] ].
		
		self checkForMissingDependencies.
		self checkForMissingClasses ]
]

{ #category : #private }
GTExampleOrganizer >> checkForDependenciesUsing: aCompiledMethod [
	[ self examples do: [ :example |
		example arguments do: [ :dependency |
			(dependency exists not and: [ dependency matchesMethod: aCompiledMethod ]) 
				ifTrue: [ self notifyForDependencyUsing: aCompiledMethod example: example ] ] ] ]
		on: Error
		do: [ :exception | " ignore " ]
]

{ #category : #private }
GTExampleOrganizer >> checkForMissingClasses [
	[ self examples ]
		on: GTExampleDeclaredClassMissing
		do: [ :exception | 
			self notifyForMissingClasses: exception ]
]

{ #category : #private }
GTExampleOrganizer >> checkForMissingClasses: aCompiledMethod [
	[ aCompiledMethod gtExamples ]
		on: GTExampleDeclaredClassMissing
		do: [ :exception | 
			self notifyForMissingClasses: exception ]
]

{ #category : #private }
GTExampleOrganizer >> checkForMissingDependencies [
	[ self examples do: [ :example | 
		example arguments do: [ :dependency | 
			dependency exists 
				ifFalse: [ self notifyForMissingDependency: dependency example: example ] ] ] ]
		on: Error
		do: [ :exception | " ignore " ]
]

{ #category : #private }
GTExampleOrganizer >> checkForMissingDependencies: aCompiledMethod [
	[ aCompiledMethod gtExamples do: [ :example | 
		example arguments do: [ :dependency | 
			dependency exists 
				ifFalse: [ self notifyForMissingDependency: dependency example: example ] ] ] ]
		on: Error
		do: [ :exception | " ignore " ]
]

{ #category : #private }
GTExampleOrganizer >> checkForNumberOfArguments: aCompiledMethod [
	[ aCompiledMethod gtExamples do: [ :example | 
		example arguments size = aCompiledMethod numArgs 
			ifFalse: [ self notifyForNumberOfArguments: example ] ] ]
		on: Error
		do: [ :exception | " ignore " ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> classRemoved: anAnnouncement [
	self withCleanupDo: [ 
		(examples removeKey: anAnnouncement classRemoved theNonMetaClass name ifAbsent: [ nil ])
			ifNotNil: [ :dict | dict do: #detachFromSystem ].
			
		self checkForMissingDependencies.
		self checkForMissingClasses ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> classRenamed: anAnnouncement [
	self withCleanupDo: [ 
		examples at: anAnnouncement oldName asSymbol ifPresent: [ :oldValue | 
			examples at: anAnnouncement newName asSymbol put: oldValue ].
		
		self checkForMissingDependencies ]
]

{ #category : #accessing }
GTExampleOrganizer >> examples [
	^ GTExampleFinder gtExamples
]

{ #category : #ui }
GTExampleOrganizer >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'Examples';
		allCandidates: [ self examples ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #initializing }
GTExampleOrganizer >> initialize [
	super initialize.
	
	self reset.
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodAdded: anAnnouncement [
	self withCleanupDo: [ 
		self checkForMissingDependencies: anAnnouncement method.
		self checkForNumberOfArguments: anAnnouncement method.
		self checkForMissingClasses: anAnnouncement method ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodModified: anAnnouncement [
	self withCleanupDo: [ 
		((examples at: anAnnouncement oldMethod methodClass theNonMetaClass name ifAbsent: [ IdentityDictionary new ])
			removeKey: anAnnouncement oldMethod selector ifAbsent: [ nil ]) detachFromSystem.
			
		self checkForMissingDependencies: anAnnouncement method.
		self checkForNumberOfArguments: anAnnouncement method.
		self checkForMissingClasses: anAnnouncement method.
		self checkForDependenciesUsing: anAnnouncement method ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodRemoved: anAnnouncement [
	self withCleanupDo: [ 
		((examples at: anAnnouncement method methodClass theNonMetaClass name ifAbsent: [ IdentityDictionary new ])
			removeKey: anAnnouncement method selector ifAbsent: [ nil ]) detachFromSystem.
			
		self checkForDependenciesUsing: anAnnouncement method ]
]

{ #category : #'private-notify' }
GTExampleOrganizer >> notify: aString exception: anException [
	UIManager default inform: (String streamContents: [ :stream | stream 
		nextPutAll: aString;
		nextPutAll: ': ';
		nextPutAll: anException messageText ])
]

{ #category : #'private-notify' }
GTExampleOrganizer >> notifyForDependencyUsing: aCompiledMethod example: anExample [
	UIManager default inform: (String streamContents: [ :stream | stream 
		nextPutAll: 'Obsolete example dependency in' ;
		cr;
		nextPutAll: anExample method methodClass name asString;
		nextPutAll: ' >> #';
		nextPutAll: anExample method selector asString ])
]

{ #category : #'private-notify' }
GTExampleOrganizer >> notifyForMissingClasses: anException [
	UIManager default inform: (String streamContents: [ :stream | stream 
		nextPutAll: 'Referenced class missing' ;
		cr;
		nextPutAll: anException classNamed asString ])
]

{ #category : #'private-notify' }
GTExampleOrganizer >> notifyForMissingDependency: aDependency example: anExample [
	UIManager default inform: (String streamContents: [ :stream | stream 
		nextPutAll: 'Missing example dependency' ;
		cr;
		nextPutAll: aDependency owner provider class name asString;
		nextPutAll: ' >> #';
		nextPutAll: aDependency selector asString ])
]

{ #category : #'private-notify' }
GTExampleOrganizer >> notifyForNumberOfArguments: anExample [
	UIManager default inform: (String streamContents: [ :stream | stream 
		nextPutAll: 'Invalid number of arguments in' ;
		cr;
		nextPutAll: anExample method methodClass name asString;
		nextPutAll: ' >> #';
		nextPutAll: anExample method selector asString ])
]

{ #category : #initializing }
GTExampleOrganizer >> reset [
	examples := IdentityDictionary new.
	Smalltalk garbageCollect; garbageCollectMost.
	GTExample allInstances do: [ :each | each detachFromSystem ].
	GTExample allSubInstances do: [ :each | each detachFromSystem ].
	GTExampleProxy allInstances do: [ :each | each detachFromSystem ].
	GTExampleProxy allSubInstances do: [ :each | each detachFromSystem ].
	GTExampleResult allInstances do: [ :each | each detachFromSystem ].
	GTExampleResult allSubInstances do: [ :each | each detachFromSystem ].
	Smalltalk garbageCollect; garbageCollectMost.
]

{ #category : #public }
GTExampleOrganizer >> running [
	^ running ifNil: [ false ]
]

{ #category : #public }
GTExampleOrganizer >> start [
	self running ifTrue: [ ^ self ].
	running := true.
	SystemAnnouncer uniqueInstance
		when: MethodAdded do: [ :anAnnouncement | self methodAdded: anAnnouncement ] for: self;
		when: MethodModified do: [ :anAnnouncement | self methodModified: anAnnouncement ] for: self;
		when: MethodRemoved do: [ :anAnnouncement | self methodRemoved: anAnnouncement ] for: self;
		when: ClassRemoved do: [ :anAnnouncement | self classRemoved: anAnnouncement ] for: self;
		when: ClassRenamed do: [ :anAnnouncement | self classRenamed: anAnnouncement ] for: self;
		when: CategoryRemoved do: [ :anAnnouncement | self categoryRemoved: anAnnouncement ] for: self.
]

{ #category : #public }
GTExampleOrganizer >> stop [
	running := false.
	SystemAnnouncer uniqueInstance
		unsubscribe: self
]

{ #category : #private }
GTExampleOrganizer >> withCleanupDo: aBlock [
	aBlock value.
	Smalltalk garbageCollect.
]
