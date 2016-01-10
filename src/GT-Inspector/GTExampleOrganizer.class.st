Class {
	#name : #GTExampleOrganizer,
	#superclass : #Object,
	#instVars : [
		'running',
		'examples',
		'notifying',
		'systemAnnouncements',
		'monticelloAnnouncements'
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
GTExampleOrganizer >> announcer [
	^ SystemAnnouncer uniqueInstance
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
	self withoutExceptionsDo: [ 
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
	[ self cachedExamplesDo: [ :example |
		example arguments do: [ :dependency |
			(dependency exists not and: [ dependency matchesMethod: aCompiledMethod ]) 
				ifTrue: [ self notifyForDependencyUsing: aCompiledMethod example: example ] ] ] ]
		on: Error
		do: [ :exception | " ignore " ]
]

{ #category : #'private-checking' }
GTExampleOrganizer >> checkForMissingClasses [
	[ self examples ]
		on: GTExampleDeclaredClassMissing
		do: [ :exception | 
			self notifyForMissingClasses: exception ]
]

{ #category : #'private-checking' }
GTExampleOrganizer >> checkForMissingClasses: aCompiledMethod [
	[ aCompiledMethod gtExamples ]
		on: GTExampleDeclaredClassMissing
		do: [ :exception | 
			self notifyForMissingClasses: exception ]
]

{ #category : #'private-checking' }
GTExampleOrganizer >> checkForMissingDependencies [
	[ self cachedExamplesDo: [ :example | 
		example arguments do: [ :dependency | 
			dependency exists 
				ifFalse: [ self notifyForMissingDependency: dependency example: example ] ] ] ]
		on: Error
		do: [ :exception | " ignore " ]
]

{ #category : #'private-checking' }
GTExampleOrganizer >> checkForMissingDependencies: aCompiledMethod [
	[ aCompiledMethod gtExamples do: [ :example | 
		example arguments do: [ :dependency | 
			dependency exists 
				ifFalse: [ self notifyForMissingDependency: dependency example: example ] ] ] ]
		on: Error
		do: [ :exception | " ignore " ]
]

{ #category : #'private-checking' }
GTExampleOrganizer >> checkForNumberOfArguments: aCompiledMethod [
	[ aCompiledMethod gtExamples do: [ :example | 
		example arguments size = aCompiledMethod numArgs 
			ifFalse: [ self notifyForNumberOfArguments: example ] ] ]
		on: Error
		do: [ :exception | " ignore " ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> classRemoved: anAnnouncement [
	self withoutExceptionsDo: [ 
		(examples removeKey: anAnnouncement classRemoved theNonMetaClass name ifAbsent: [ nil ])
			ifNotNil: [ :dict | 
				dict do: [ :example |
					[ example detachFromSystem ] on: Error do: [ " ignore " ] ].
				self checkForMissingDependencies.
				self checkForMissingClasses ] ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> classRenamed: anAnnouncement [
	self withoutExceptionsDo: [ 
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
	
	self reset
]

{ #category : #OBSOLETE }
GTExampleOrganizer >> jobEnded: anAnnouncement [
	self deprecated: 'a call of this method means, there are still old job announcements in this image. we do nothing here except wiping all previous announcers. we reset this instance to use the new announcers'.
	[ self stopThoroughly; reset; start ] on: Error do: [ " ignore " ]
]

{ #category : #OBSOLETE }
GTExampleOrganizer >> jobStarted: anAnnouncement [
	self deprecated: 'a call of this method means, there are still old job announcements in this image. we do nothing here except wiping all previous announcers. we reset this instance to use the new announcers'.
	[ self stopThoroughly; reset; start ] on: Error do: [ " ignore " ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> loadStarted: anAnnouncement [
	self withoutExceptionsDo: [
		self stopSystemAnnouncements.
		self resetQuickly " we must get rid of all example objects lying around - this is really important for consistency " ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> loadStopped: anAnnouncement [
	self withoutExceptionsDo: [ 
		self startSystemAnnouncements ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodAdded: anAnnouncement [
	self withoutExceptionsDo: [
		self checkForMissingDependencies: anAnnouncement method.
		self checkForNumberOfArguments: anAnnouncement method.
		self checkForMissingClasses: anAnnouncement method.
		GTExampleNautilus methodChanged: anAnnouncement method ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodModified: anAnnouncement [
	self withoutExceptionsDo: [ 
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
	self withoutExceptionsDo: [ 
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

{ #category : #OBSOLETE }
GTExampleOrganizer >> notifying [
	self deprecated: 'do not use anymore / there is no replacement'.
	^ false
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
	" this is expensive, but thorough and makes sure the gc will really get rid of all gtexample-related objects "
	examples := WeakIdentityKeyDictionary new.
	GTExample allSubInstances do: [ :each | [ each detachFromSystem ] on: Error do: [ " ignore / do not abort " ] ].
	GTExampleProxy allSubInstances do: [ :each | [ each detachFromSystem ] on: Error do: [ " ignore / do not abort " ] ].
	self resetResultsOnly.
]

{ #category : #initializing }
GTExampleOrganizer >> resetQuickly [
	" we assume the thorough reset was already performed if there are no examples in here "
	examples isEmptyOrNil ifTrue: [ ^ self ].
	self reset
]

{ #category : #OBSOLETE }
GTExampleOrganizer >> resetResults [
	self deprecated: 'we wipe everything as a temporar solution'.
	self resetResultsOnly
]

{ #category : #initializing }
GTExampleOrganizer >> resetResultsOnly [
	" this is expensive, but thorough and makes sure the gc will really get rid of all gtexample-result-related objects "
	GTExampleResult allSubInstances do: [ :each | [ each detachFromSystem ] on: Error do: [ " ignore / do not abort " ] ].
]

{ #category : #OBSOLETE }
GTExampleOrganizer >> running [
	self deprecated: 'do not use anymore / there is no replacement'.
	^ true
]

{ #category : #public }
GTExampleOrganizer >> start [
	self startMonticelloAnnouncements.
	self startSystemAnnouncements
]

{ #category : #'private-announcers' }
GTExampleOrganizer >> startMonticelloAnnouncements [
	monticelloAnnouncements == true ifTrue: [ ^ self ]. " handle: nil | false | true / avoid multiple subscriptions "
	self announcer
		when: MCVersionLoaderStarted do: [ :anAnnouncement | self loadStarted: anAnnouncement ] for: self;
		when: MCVersionLoaderStopped do: [ :anAnnouncement | self loadStopped: anAnnouncement ] for: self.
	monticelloAnnouncements := true
]

{ #category : #'private-announcers' }
GTExampleOrganizer >> startSystemAnnouncements [
	systemAnnouncements == true ifTrue: [ ^ self ]. " handle: nil | false | true / avoid multiple subscriptions "
	self announcer
		when: MethodAdded do: [ :anAnnouncement | self methodAdded: anAnnouncement ] for: self;
		when: MethodModified do: [ :anAnnouncement | self methodModified: anAnnouncement ] for: self;
		when: MethodRemoved do: [ :anAnnouncement | self methodRemoved: anAnnouncement ] for: self;
		when: ClassRemoved do: [ :anAnnouncement | self classRemoved: anAnnouncement ] for: self;
		when: ClassRenamed do: [ :anAnnouncement | self classRenamed: anAnnouncement ] for: self;
		when: CategoryRemoved do: [ :anAnnouncement | self categoryRemoved: anAnnouncement ] for: self.
	systemAnnouncements := true
]

{ #category : #public }
GTExampleOrganizer >> stop [
	self stopMonticelloAnnouncements.
	self stopSystemAnnouncements
]

{ #category : #OBSOLETE }
GTExampleOrganizer >> stopJobAnnouncements [
	self deprecated: 'a call of this method means, there are still old announcements in this image. we do nothing here except wiping all previous announcers.'.
	[ self stopThoroughly; reset ] on: Error do: [ " ignore " ]
]

{ #category : #'private-announcers' }
GTExampleOrganizer >> stopMonticelloAnnouncements [
	self announcer unsubscribe: self.
	monticelloAnnouncements := false
]

{ #category : #'private-announcers' }
GTExampleOrganizer >> stopSystemAnnouncements [
	self announcer	unsubscribe: self.
	systemAnnouncements := false
]

{ #category : #public }
GTExampleOrganizer >> stopThoroughly [
	self stop.
	
	Announcer allSubInstances do: [ :each | each unsubscribeThoroughly: self class ]
]

{ #category : #OBSOLETE }
GTExampleOrganizer >> withCleanupDo: aBlock [
	self deprecated: 'use #withoutExceptionsDo: instead'.
	self withoutExceptionsDo: aBlock
]

{ #category : #private }
GTExampleOrganizer >> withoutExceptionsDo: aBlock [
	[ aBlock value ]
		on: Error
		do: [ :exception | " we should not ignore it, but try to continue " ]
]
