Class {
	#name : #GTEventDelivery,
	#superclass : #Object,
	#instVars : [
		'mutex',
		'process',
		'delay',
		'permission',
		'recorder',
		'queue'
	],
	#category : #'GT-EventRecorder-Core'
}

{ #category : #activation }
GTEventDelivery >> activate [
	"Initialize a delivery process if permitted and necessary."
	^ mutex critical: [ 
			self hasPermission ifFalse: [ ^ self ].
			self isInactive ifTrue: [ self initializeProcess ].
			process ]
]

{ #category : #adding }
GTEventDelivery >> add: packByteArray [
	queue nextPut: packByteArray
]

{ #category : #announce }
GTEventDelivery >> announceSuspendingDelivery [
	self announcer announce: GTEventSuspendingDeliveryAnnouncement
]

{ #category : #accessing }
GTEventDelivery >> announcer [
	^ self recorder announcer
]

{ #category : #deactivation }
GTEventDelivery >> deactivate [
	^ mutex critical: [ | oldProcess |
		self withdrawPermission.
		delay ifNotNil: [ :aDelay | aDelay delaySemaphore signal ].
		oldProcess := process.
		process := nil.
		oldProcess ]
]

{ #category : #delivery }
GTEventDelivery >> deliver: aBoolean [
	queue flush: [ :eachByteArray |
		self deliver: eachByteArray signalProgress: aBoolean ]
]

{ #category : #delivery }
GTEventDelivery >> deliver: aGTEventBundle signalProgress: aBoolean [
	^ (ZnClient new
			beOneShot;
			timeout: 5;
			signalProgress: aBoolean;
			numberOfRetries: 0;
			url: aGTEventBundle url;
			enforceHttpSuccess: true;
			ifFail: [ :exception | queue nextPut: aGTEventBundle ];
			entity: (ZnByteArrayEntity bytes: aGTEventBundle data);
			put;
			response)
]

{ #category : #initialization }
GTEventDelivery >> deliveryCycle [
	delay := self standardDuration asDelay.
	self announceSuspendingDelivery.
	delay wait.
	delay := nil.
	self hasPermission ifTrue: [ self packAndDeliver: false ]
]

{ #category : #testing }
GTEventDelivery >> hasPermission [
	^ permission
]

{ #category : #initialization }
GTEventDelivery >> initialize [
	super initialize.
	mutex := Mutex new.
	queue := WaitfreeQueue new.
	permission := true.
]

{ #category : #initialization }
GTEventDelivery >> initializeProcess [
	process := [ [ self hasPermission ] whileTrue: [ self deliveryCycle ] ]
		forkAt: Processor userBackgroundPriority
		named: self printProcessName
]

{ #category : #testing }
GTEventDelivery >> isActive [
	^ self isInactive not
]

{ #category : #testing }
GTEventDelivery >> isGlobalRecorder [
	^ self recorder 
			ifNil: false
			ifNotNil: #isGlobalRecorder
]

{ #category : #testing }
GTEventDelivery >> isInactive [
	^ mutex critical: [ 
		process isNil or: [
			process isTerminated or: [
				process isTerminating ] ] ]
]

{ #category : #delivery }
GTEventDelivery >> now [
	"for testing purpose"
	delay ifNotNil: [ :aDelay | aDelay delaySemaphore signal. aDelay unschedule. ]
]

{ #category : #activation }
GTEventDelivery >> offerPermission [
	mutex critical: [ permission := true ]
]

{ #category : #delivery }
GTEventDelivery >> packAndDeliver: aBoolean. [
	recorder pack.
	self deliver: aBoolean.
	
]

{ #category : #printing }
GTEventDelivery >> printOn: aStream [
	super printOn: aStream.
	aStream
		space;
		nextPut: $[;
		nextPutAll: (queue size pluralize: 'item').
	self isActive
		ifTrue: [ 
			delay 
				ifNil: [ aStream nextPutAll: 'process active, but delay is nil!' ]
				ifNotNil: [ :aDelay |
					aStream
						nextPutAll: ', next cycle in ';
						print: (aDelay millisecondsToGo milliseconds roundTo: 1 second);
						nextPutAll: ' sec' ] ]
		ifFalse: [ 
			aStream nextPutAll: ', inactive' ].
	aStream		
		nextPut: $]
]

{ #category : #printing }
GTEventDelivery >> printProcessName [
	^ String streamContents: [ :aStream |
		self printProcessNameOn: aStream ]
]

{ #category : #printing }
GTEventDelivery >> printProcessNameOn: aStream [
	aStream
		nextPutAll: self className.
	self isGlobalRecorder
		ifTrue: [ aStream nextPutAll: ' global ' ]
		ifFalse: [ aStream nextPutAll: ' a ' ].
	aStream nextPutAll: 'delivery process'
]

{ #category : #accessing }
GTEventDelivery >> recorder [
	^ recorder
]

{ #category : #accessing }
GTEventDelivery >> recorder: anObject [
	recorder := anObject
]

{ #category : #accessing }
GTEventDelivery >> size [
	^ queue size
]

{ #category : #accessing }
GTEventDelivery >> standardDuration [
	^ 20 minutes
]

{ #category : #deactivation }
GTEventDelivery >> withdrawPermission [
	mutex critical: [ permission := false ]
]
