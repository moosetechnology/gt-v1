Class {
	#name : #GTOUser,
	#superclass : #Object,
	#instVars : [
		'options',
		'nickname'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #'as yet unclassified' }
GTOUser class >> named: aString [ 
	^ self new nickname: aString; yourself
]

{ #category : #comparing }
GTOUser >> = anObject [
	^ self == anObject or: [ 
		 self class = anObject class and: [ 
			self nickname = anObject nickname ] ]
]

{ #category : #testing }
GTOUser >> isOnline [
	^ self 
		optionAt: #onlineSince
		ifPresent: [ :aDateAndTime | DateAndTime now - aDateAndTime < 10 minutes ]
		ifAbsent: [ false ]
]

{ #category : #accessing }
GTOUser >> nickname [
	^ nickname
]

{ #category : #accessing }
GTOUser >> nickname: aString [ 
	nickname := aString
]

{ #category : #accessing }
GTOUser >> onlineSince: aDateAndTime [ 
	self optionAt: #onlineSince put: aDateAndTime
]

{ #category : #accessing }
GTOUser >> optionAt: aSymbol ifAbsent: aBlockClosure [ 
	options ifNil: [ ^ aBlockClosure value ].
	^ options at: aSymbol ifAbsent: aBlockClosure 
]

{ #category : #accessing }
GTOUser >> optionAt: aSymbol ifPresent: presentBlock ifAbsent: absentBlock [ 
	options ifNil: [ ^ absentBlock value ].
	^ options at: aSymbol ifPresent: presentBlock ifAbsent: absentBlock 
]

{ #category : #accessing }
GTOUser >> optionAt: aSymbol put: anObject [ 
	options ifNil: [ options := Dictionary new ].
	^ options at: aSymbol put: anObject
]

{ #category : #printing }
GTOUser >> printOn: aStream [
	self nickname 
		ifNil: [ aStream nextPutAll: 'a user' ]
		ifNotNil: [ aStream print: self nickname ].
	self isOnline
		ifTrue: [ aStream nextPutAll: ' is online' ]
		ifFalse: [ aStream nextPutAll: ' is offline' ]
]
