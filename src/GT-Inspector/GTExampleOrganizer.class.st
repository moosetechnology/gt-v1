Class {
	#name : #GTExampleOrganizer,
	#superclass : #Object,
	#instVars : [
		'running',
		'examples',
		'notifying',
		'notifyingBeforeJobStarted'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'GT-Inspector-Examples-Utils'
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
	<todo: '#theNonMetaClass is not good since we could not put examples to the instance and class-side at once'>
	^ (examples 
		at: aCompiledMethod methodClass theNonMetaClass name 
		ifAbsentPut: [ WeakIdentityKeyDictionary new ]) 
			at: aCompiledMethod selector 
			ifAbsentPut: aBlock
]

{ #category : #private }
GTExampleOrganizer >> cachedExamplesDo: aBlock [
	examples do: [ :selectorsAndExamples |
		selectorsAndExamples do: aBlock ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> categoryRemoved: anAnnouncement [
	self withCleanupDo: [ 
		examples keys do: [ :className |
			(Smalltalk classNamed: className) ifNil: [ 
				(examples removeKey: className ifAbsent: [ nil ]) ifNotNil: [ :dict | 
					dict do: [ :example | 
						[ example detachFromSystem ] on: Error do: [ " ignore " ] ] ] ] ].
		
		self checkForMissingDependencies.
		self checkForMissingClasses ]
]

{ #category : #'private-checking' }
GTExampleOrganizer >> checkForDependenciesUsing: aCompiledMethod [
	self notifying ifFalse: [ ^ self ].
	
	[ self cachedExamplesDo: [ :example |
		example arguments do: [ :dependency |
			(dependency exists not and: [ dependency matchesMethod: aCompiledMethod ]) 
				ifTrue: [ self notifyForDependencyUsing: aCompiledMethod example: example ] ] ] ]
		on: Error
		do: [ :exception | " ignore " ]
]

{ #category : #'private-checking' }
GTExampleOrganizer >> checkForMissingClasses [
	self notifying ifFalse: [ ^ self ].

	[ self examples ]
		on: GTExampleDeclaredClassMissing
		do: [ :exception | 
			self notifyForMissingClasses: exception ]
]

{ #category : #'private-checking' }
GTExampleOrganizer >> checkForMissingClasses: aCompiledMethod [
	self notifying ifFalse: [ ^ self ].

	[ aCompiledMethod gtExamples ]
		on: GTExampleDeclaredClassMissing
		do: [ :exception | 
			self notifyForMissingClasses: exception ]
]

{ #category : #'private-checking' }
GTExampleOrganizer >> checkForMissingDependencies [
	self notifying ifFalse: [ ^ self ].

	[ self cachedExamplesDo: [ :example | 
		example arguments do: [ :dependency | 
			dependency exists 
				ifFalse: [ self notifyForMissingDependency: dependency example: example ] ] ] ]
		on: Error
		do: [ :exception | " ignore " ]
]

{ #category : #'private-checking' }
GTExampleOrganizer >> checkForMissingDependencies: aCompiledMethod [
	self notifying ifFalse: [ ^ self ].

	[ aCompiledMethod gtExamples do: [ :example | 
		example arguments do: [ :dependency | 
			dependency exists 
				ifFalse: [ self notifyForMissingDependency: dependency example: example ] ] ] ]
		on: Error
		do: [ :exception | " ignore " ]
]

{ #category : #'private-checking' }
GTExampleOrganizer >> checkForNumberOfArguments: aCompiledMethod [
	self notifying ifFalse: [ ^ self ].

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
			ifNotNil: [ :dict | 
				dict do: [ :example |
					[ example detachFromSystem ] on: Error do: [ " ignore " ] ].
			
				self checkForMissingDependencies.
				self checkForMissingClasses ] ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> classRenamed: anAnnouncement [
	self withCleanupDo: [ 
		examples at: anAnnouncement oldName asSymbol ifPresent: [ :oldValue | 
			examples at: anAnnouncement newName asSymbol put: oldValue ].
		
		self checkForMissingDependencies ]
]

{ #category : #private }
GTExampleOrganizer >> examples [
	^ GTExampleFinder allGTExamples
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
GTExampleOrganizer >> jobEnded: anAnnouncement [
	notifying := notifyingBeforeJobStarted.
	notifyingBeforeJobStarted := nil.
]

{ #category : #'private-events' }
GTExampleOrganizer >> jobStarted: anAnnouncement [
	notifyingBeforeJobStarted := notifying.
	notifying := false
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodAdded: anAnnouncement [
	self withCleanupDo: [
		self checkForMissingDependencies: anAnnouncement method.
		self checkForNumberOfArguments: anAnnouncement method.
		self checkForMissingClasses: anAnnouncement method.
		GTExampleNautilus methodChanged: anAnnouncement method ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodModified: anAnnouncement [
	self withCleanupDo: [ 
		((examples at: anAnnouncement oldMethod methodClass theNonMetaClass name ifAbsent: [ IdentityDictionary new ])
			removeKey: anAnnouncement oldMethod selector ifAbsent: [ nil ]) ifNotNil: [ :example |
				[ example detachFromSystem ] on: Error do: [ " ignore " ].
			
				self checkForMissingDependencies: anAnnouncement method.
				self checkForNumberOfArguments: anAnnouncement method.
				self checkForMissingClasses: anAnnouncement method.
				self checkForDependenciesUsing: anAnnouncement method.
				GTExampleNautilus methodChanged: anAnnouncement method.
				GTExampleNautilus methodChanged: anAnnouncement oldMethod ] ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodRemoved: anAnnouncement [
	self withCleanupDo: [ 
		((examples at: anAnnouncement method methodClass theNonMetaClass name ifAbsent: [ IdentityDictionary new ])
			removeKey: anAnnouncement method selector ifAbsent: [ nil ]) ifNotNil: [ :example |
				[ example detachFromSystem ] on: Error do: [ " ignore " ].
			
				self checkForDependenciesUsing: anAnnouncement method.
				GTExampleNautilus methodChanged: anAnnouncement method.  ] ]
]

{ #category : #'private-notifying' }
GTExampleOrganizer >> notify: aString exception: anException [
	UIManager default inform: (String streamContents: [ :stream | stream 
		nextPutAll: aString;
		nextPutAll: ': ';
		nextPutAll: anException messageText ])
]

{ #category : #'private-notifying' }
GTExampleOrganizer >> notifyForDependencyUsing: aCompiledMethod example: anExample [
	UIManager default inform: (String streamContents: [ :stream | stream 
		nextPutAll: 'Obsolete example dependency in' ;
		cr;
		nextPutAll: anExample method methodClass name asString;
		nextPutAll: ' >> #';
		nextPutAll: anExample method selector asString ])
]

{ #category : #'private-notifying' }
GTExampleOrganizer >> notifyForMissingClasses: anException [
	UIManager default inform: (String streamContents: [ :stream | stream 
		nextPutAll: 'Referenced class missing' ;
		cr;
		nextPutAll: anException classNamed asString ])
]

{ #category : #'private-notifying' }
GTExampleOrganizer >> notifyForMissingDependency: aDependency example: anExample [
	UIManager default inform: (String streamContents: [ :stream | stream 
		nextPutAll: 'Missing example dependency' ;
		cr;
		nextPutAll: aDependency owner provider class name asString;
		nextPutAll: ' >> #';
		nextPutAll: aDependency selector asString ])
]

{ #category : #'private-notifying' }
GTExampleOrganizer >> notifyForNumberOfArguments: anExample [
	UIManager default inform: (String streamContents: [ :stream | stream 
		nextPutAll: 'Invalid number of arguments in' ;
		cr;
		nextPutAll: anExample method methodClass name asString;
		nextPutAll: ' >> #';
		nextPutAll: anExample method selector asString ])
]

{ #category : #public }
GTExampleOrganizer >> notifying [
	^ notifying ifNil: [ false ]
]

{ #category : #accessing }
GTExampleOrganizer >> removeAtMethod: aCompiledMethod ifPresent: aBlock [
	(examples 
		at: aCompiledMethod methodClass theNonMetaClass name 
		ifAbsent: [ ^ nil ]) 
			removeKey: aCompiledMethod selector 
			ifAbsent: [ ^ nil ].
	(examples at: aCompiledMethod methodClass theNonMetaClass name) 
		ifEmpty: [ examples removeKey: aCompiledMethod methodClass theNonMetaClass name ].
	aBlock value.
	^ aCompiledMethod
]

{ #category : #initializing }
GTExampleOrganizer >> reset [
	examples := WeakIdentityKeyDictionary new.
	GTExample allSubInstances do: [ :each | [ each detachFromSystem ] on: Error do: [ " ignore / do not abort " ] ].
	GTExampleProxy allSubInstances do: [ :each | [ each detachFromSystem ] on: Error do: [ " ignore / do not abort " ] ].
	GTExampleResult allSubInstances do: [ :each | [ each detachFromSystem ] on: Error do: [ " ignore / do not abort " ] ].
]

{ #category : #initializing }
GTExampleOrganizer >> resetResults [
	GTExampleResult allSubInstances do: [ :each | [ each detachFromSystem ] on: Error do: [ " ignore / do not abort " ] ].
]

{ #category : #public }
GTExampleOrganizer >> running [
	^ running ifNil: [ false ]
]

{ #category : #public }
GTExampleOrganizer >> start [
	self running ifTrue: [ ^ self ].
	
	running := true.
	notifying := true.
	notifyingBeforeJobStarted := notifying.
	
	" MC will load using a Job object, we have to be quiet and fast while this happens "
	Job jobAnnouncer
		when: JobStart do: [ :anAnnouncement | self jobStarted: anAnnouncement ] for: self;
		when: JobEnd do: [ :anAnnouncement | self jobEnded: anAnnouncement ] for: self.
	
	" Observe the system for relevant changes, try to keep this cache intact "
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
	notifying := false.
	SystemAnnouncer uniqueInstance	unsubscribe: self.
	Job jobAnnouncer unsubscribe: self.
]

{ #category : #private }
GTExampleOrganizer >> withCleanupDo: aBlock [
	[ aBlock value ]
		on: Error
		do: [ :exception | " we should not ignore it, but try to continue " ].
	"self notifying ifTrue: [ Smalltalk garbageCollect ]"
]
