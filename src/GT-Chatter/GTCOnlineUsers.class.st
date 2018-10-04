Class {
	#name : #GTCOnlineUsers,
	#superclass : #Object,
	#instVars : [
		'monitor',
		'users',
		'lastWhoIsOnlineQuestionTimestamp'
	],
	#category : #'GT-Chatter-Model'
}

{ #category : #adding }
GTCOnlineUsers >> addOnlineUser: aGTCOnlineClient [ 
	^ monitor critical: [ 
		users removeAllSuchThat: [ :each | each isFrom: aGTCOnlineClient from ].
		users add: aGTCOnlineClient. ]
]

{ #category : #accessing }
GTCOnlineUsers >> all [
	"get all users"
	^ monitor critical: [ users collect: #from ]
]

{ #category : #testing }
GTCOnlineUsers >> includes: aClientId [ 
	^ monitor critical: [ users anySatisfy: [ :each | each from = aClientId ] ]
]

{ #category : #initialization }
GTCOnlineUsers >> initialize [
	super initialize.
	monitor := Monitor new.
	users := OrderedCollection new.
]

{ #category : #accessing }
GTCOnlineUsers >> onlineSince: aDateAndTime [ 
	^ monitor critical: [ 
		users 
			select: [ :each | each timestamp > aDateAndTime ]
			thenCollect: #from ]
]

{ #category : #protocol }
GTCOnlineUsers >> receivedWhoIsOnline: aGTCWhoIsOnline [ 
	lastWhoIsOnlineQuestionTimestamp := aGTCWhoIsOnline timestamp.
]

{ #category : #accessing }
GTCOnlineUsers >> recent [
	"get recently online users"
	^ self onlineSince: self recentTimestamp
]

{ #category : #accessing }
GTCOnlineUsers >> recentTimestamp [
	^ (lastWhoIsOnlineQuestionTimestamp ifNil: [ DateAndTime now ]) - 1 minute
]

{ #category : #removing }
GTCOnlineUsers >> removeAll [
	"useful for test cases"
	monitor critical: [ users removeAll ]
]

{ #category : #accessing }
GTCOnlineUsers >> size [
	^ monitor critical: [ users size ]
]
