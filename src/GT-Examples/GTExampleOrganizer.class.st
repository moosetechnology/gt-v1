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

{ #category : #public }
GTExampleOrganizer class >> instance [
	^ instance ifNil: [ instance := self basicNew initialize start ]
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

{ #category : #'private-events' }
GTExampleOrganizer >> categoryRemoved: anAnnouncement [
	self withoutExceptionsDo: [ 
		self reset ]
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

{ #category : #initializing }
GTExampleOrganizer >> initialize [
	super initialize.
	
	theNonMetaClassExamples := WeakIdentityKeyDictionary new.
	theMetaClassExamples := WeakIdentityKeyDictionary new.
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

{ #category : #public }
GTExampleOrganizer >> regenerate [
	SmalltalkImage current gtExamplesContained
]

{ #category : #public }
GTExampleOrganizer >> reset [
	self initialize
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
