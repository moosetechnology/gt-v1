Class {
	#name : #GTExampleOrganizer,
	#superclass : #Object,
	#instVars : [
		'examples',
		'theNonMetaClassExamples',
		'theMetaClassExamples',
		'systemAnnouncements',
		'monticelloAnnouncements'
	],
	#classInstVars : [
		'instance'
	],
	#category : #'GT-Examples-Utils'
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
	instance ifNotNil: [ instance stop ].
	self reset
]

{ #category : #private }
GTExampleOrganizer >> announcer [
	^ SystemAnnouncer uniqueInstance weak
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

{ #category : #DEPRECATED }
GTExampleOrganizer >> cachedExamplesDo: aBlock [
	examples do: [ :selectorsAndExamples |
		selectorsAndExamples do: aBlock ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> categoryRemoved: anAnnouncement [
	self withoutExceptionsDo: [ 
		self reset ]
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> checkForDependenciesUsing: aCompiledMethod [
	[ self cachedExamplesDo: [ :example |
		example arguments do: [ :dependency |
			(dependency exists not and: [ dependency matchesMethod: aCompiledMethod ]) 
				ifTrue: [ self notifyForDependencyUsing: aCompiledMethod example: example ] ] ] ]
		on: Error
		do: [ :exception | " ignore " ]
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> checkForMissingClasses [
	[ GTExampleFinder allGTExamples ]
		on: GTExampleDeclaredClassMissing
		do: [ :exception | 
			self notifyForMissingClasses: exception ]
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> checkForMissingClasses: aCompiledMethod [
	[ aCompiledMethod gtExamples ]
		on: GTExampleDeclaredClassMissing
		do: [ :exception | 
			self notifyForMissingClasses: exception ]
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> checkForMissingDependencies [
	[ self cachedExamplesDo: [ :example | 
		example arguments do: [ :dependency | 
			dependency exists 
				ifFalse: [ self notifyForMissingDependency: dependency example: example ] ] ] ]
		on: Error
		do: [ :exception | " ignore " ]
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> checkForMissingDependencies: aCompiledMethod [
	[ aCompiledMethod gtExamples do: [ :example | 
		example arguments do: [ :dependency | 
			dependency exists 
				ifFalse: [ self notifyForMissingDependency: dependency example: example ] ] ] ]
		on: Error
		do: [ :exception | " ignore " ]
]

{ #category : #DEPRECATED }
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
		theNonMetaClassExamples removeKey: anAnnouncement classRemoved theNonMetaClass name ifAbsent: [  ].
		theMetaClassExamples removeKey: anAnnouncement classRemoved theNonMetaClass name ifAbsent: [  ] ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> classRenamed: anAnnouncement [
	self withoutExceptionsDo: [ 
		theNonMetaClassExamples removeKey: anAnnouncement oldName asSymbol ifAbsent: [  ].
		theMetaClassExamples removeKey: anAnnouncement oldName asSymbol ifAbsent: [  ] ]
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> example: oldExample modified: anAnnouncement [
	anAnnouncement method gtExamples do: [ :example |
		self announcer announce: (GTExampleModified new
			oldExample: oldExample;
			example: example;
			yourself) ]
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> example: oldExample removed: anAnnouncement [
	self announcer announce: (GTExampleRemoved new
		example: oldExample;
		yourself)
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> exampleAdded: anAnnouncement [
	anAnnouncement method gtExamples do: [ :example |
		self announcer announce: (GTExampleAdded new 
			example: example;
			yourself) ]
]

{ #category : #accessing }
GTExampleOrganizer >> exampleAt: aCompiledMethod ifAbsentPut: aBlock [
	^ self exampleAtClass: aCompiledMethod methodClass selector: aCompiledMethod selector ifAbsentPut: aBlock
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> exampleAtClass: class selector: selector ifAbsentPut: aBlock [
	((class isMeta 
		ifTrue: [ theMetaClassExamples ]
		ifFalse: [ theNonMetaClassExamples ]) 
			at: class name
			ifAbsentPut: [ WeakIdentityKeyDictionary new ]) 
				at: selector 
				ifAbsentPut: aBlock
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> examples [
	self deprecated: 'do not use anymore / there is no replacement'.
	^ GTExampleFinder allGTExamples
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> examplesDo: aBlock [
	theNonMetaClassExamples keysAndValuesDo: [ :className :methodDict |
		methodDict keysAndValuesDo: [ :selector :example | 
			aBlock value: className value: selector value: example ] ].
	theMetaClassExamples keysAndValuesDo: [ :className :methodDict |
		methodDict keysAndValuesDo: [ :selector :example | 
			aBlock value: className value: selector value: example ] ]
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> examplesOfClass: class do: aBlock [
	(theNonMetaClassExamples at: class name ifAbsent: [ nil ]) ifNotNilDo: [ :methodDict |
		methodDict keysAndValuesDo: [ :selector :example | 
			aBlock value: class value: selector value: example ] ].
	(theNonMetaClassExamples at: class name ifAbsent: [ nil ]) ifNotNilDo: [ :methodDict |
		methodDict keysAndValuesDo: [ :selector :example | 
			aBlock value: class value: selector value: example ] ]
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> examplesOfMethod: aCompiledMethod do: aBlock [
	aBlock value: aCompiledMethod methodClass name value: aCompiledMethod selector value: (((aCompiledMethod methodClass isMeta 
		ifTrue: [ theMetaClassExamples ]
		ifFalse: [ theNonMetaClassExamples ]) 
			at: aCompiledMethod methodClass name
			ifAbsent: [ ^ self ]) 
				at: aCompiledMethod selector 
				ifAbsent: [ ^ self ])
]

{ #category : #ui }
GTExampleOrganizer >> gtSpotterGTExamplesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'Examples';
		allCandidates: [ GTExampleFinder allGTExamples ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #initializing }
GTExampleOrganizer >> initialize [
	super initialize.
	
	theNonMetaClassExamples := WeakIdentityKeyDictionary new.
	theMetaClassExamples := WeakIdentityKeyDictionary new.
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> jobEnded: anAnnouncement [
	<deprecated: 'a call of this method means, there are still old job announcements in this image based on this instance. we do nothing here except wiping all previous announcers. we reset/fix this instance to use the new announcers'>
	[ self stopThoroughly; reset; start; loadStopped: anAnnouncement ] on: Error do: [ " ignore " ]
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> jobStarted: anAnnouncement [
	<deprecated: 'a call of this method means, there are still old job announcements in this image based on this instance. we do nothing here except wiping all previous announcers. we reset/fix this instance to use the new announcers'>
	[ self stopThoroughly; reset; start; loadStarted: anAnnouncement ] on: Error do: [ " ignore " ]
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
	self withoutExceptionsDo: [ ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodModified: anAnnouncement [
	self withoutExceptionsDo: [ 
		theNonMetaClassExamples removeKey: anAnnouncement classRemoved theNonMetaClass name thenDo: [ :methodDict |
			methodDict removeKey: anAnnouncement method selector ifAbsent: [  ] ].
		theMetaClassExamples removeKey: anAnnouncement classRemoved theNonMetaClass name thenDo: [ :methodDict |
			methodDict removeKey: anAnnouncement method selector ifAbsent: [  ] ] ]
]

{ #category : #'private-events' }
GTExampleOrganizer >> methodRemoved: anAnnouncement [
	self withoutExceptionsDo: [ 
		theNonMetaClassExamples removeKey: anAnnouncement oldMethod methodClass theNonMetaClass name thenDo: [ :methodDict |
			methodDict removeKey: anAnnouncement oldMethod selector ifAbsent: [  ] ].
		theMetaClassExamples removeKey: anAnnouncement oldMethod methodClass theNonMetaClass name thenDo: [ :methodDict |
			methodDict removeKey: anAnnouncement oldMethod selector ifAbsent: [  ] ] ]
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> notify: aString exception: anException [
	UIManager default inform: (String streamContents: [ :stream | stream 
		nextPutAll: aString;
		nextPutAll: ': ';
		nextPutAll: anException messageText ])
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> notifyForDependencyUsing: aCompiledMethod example: anExample [
	anExample ignoreNotification ifTrue: [ ^ self ].
	UIManager default inform: (String streamContents: [ :stream | stream 
		nextPutAll: 'Obsolete example dependency in' ;
		cr;
		nextPutAll: anExample method methodClass name asString;
		nextPutAll: ' >> #';
		nextPutAll: anExample method selector asString ])
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> notifyForMissingClasses: anException [
	UIManager default inform: (String streamContents: [ :stream | stream 
		nextPutAll: 'Referenced class missing' ;
		cr;
		nextPutAll: anException classNamed asString ])
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> notifyForMissingDependency: aDependency example: anExample [
	anExample ignoreNotification ifTrue: [ ^ self ].
	UIManager default inform: (String streamContents: [ :stream | stream 
		nextPutAll: 'Missing example dependency' ;
		cr;
		nextPutAll: aDependency owner provider class name asString;
		nextPutAll: ' >> #';
		nextPutAll: aDependency selector asString ])
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> notifyForNumberOfArguments: anExample [
	anExample ignoreNotification ifTrue: [ ^ self ].
	UIManager default inform: (String streamContents: [ :stream | stream 
		nextPutAll: 'Invalid number of arguments in' ;
		cr;
		nextPutAll: anExample method methodClass name asString;
		nextPutAll: ' >> #';
		nextPutAll: anExample method selector asString ])
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> notifying [
	self deprecated: 'do not use anymore / there is no replacement'.
	^ false
]

{ #category : #public }
GTExampleOrganizer >> regenerate [
	SmalltalkImage current gtExamplesContained
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

{ #category : #public }
GTExampleOrganizer >> reset [
	self initialize
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> resetQuickly [
	" we assume the thorough reset was already performed if there are no examples in here "
	examples isEmptyOrNil ifTrue: [ ^ self ].
	self reset
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> resetResults [
	self deprecated: 'do not use anymore / we wipe everything as a temporar solution'.
	self resetResultsOnly
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> resetResultsOnly [
	" this is expensive, but thorough and makes sure the gc will really get rid of all gtexample-result-related objects "
	GTExampleResult allSubInstances do: [ :each | [ each detachFromSystem ] on: Error do: [ " ignore / do not abort " ] ].
]

{ #category : #DEPRECATED }
GTExampleOrganizer >> running [
	self deprecated: 'do not use anymore / there is no replacement'.
	^ true
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

{ #category : #DEPRECATED }
GTExampleOrganizer >> stopJobAnnouncements [
	<deprecated: 'a call of this method means, there are still old announcements in this image. we do nothing here except wiping all previous announcers.'>
	Job jobAnnouncer unsubscribeThoroughly: self
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

{ #category : #DEPRECATED }
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
