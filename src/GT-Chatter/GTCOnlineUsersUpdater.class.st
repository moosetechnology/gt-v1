Class {
	#name : #GTCOnlineUsersUpdater,
	#superclass : #Object,
	#instVars : [
		'chatter',
		'process',
		'monitor',
		'shouldContinue',
		'delay'
	],
	#category : #'GT-Chatter-Model'
}

{ #category : #protocol }
GTCOnlineUsersUpdater >> askWhoIsOnline [
	chatter ifNotNil: [ :aChatter | aChatter whoIsOnline ]
]

{ #category : #accessing }
GTCOnlineUsersUpdater >> chatter: aChatter [
	chatter := aChatter
]

{ #category : #initialization }
GTCOnlineUsersUpdater >> initialize [
	super initialize.
	monitor := Monitor new.
]

{ #category : #protocol }
GTCOnlineUsersUpdater >> start [
	monitor critical: [ 
		process ifNotNil: [ :aProcess | aProcess isTerminated ifFalse: [ ^ self ] ].
		shouldContinue := true.
		delay := 1 minute asDelay.
		process := [ 
			[ shouldContinue ] whileTrue: [ 
				self askWhoIsOnline.
				delay wait ] ] fork ]
]

{ #category : #protocol }
GTCOnlineUsersUpdater >> stop [
	monitor critical: [ 
		shouldContinue := false.
		process := nil.
		delay ifNotNil: [ :aDelay | aDelay delaySemaphore signal ].
		delay := nil. ]
]
