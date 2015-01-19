Class {
	#name : #GTMessageHolder,
	#superclass : #Object,
	#instVars : [
		'message',
		'timestamp'
	],
	#category : #'GT-Chatter-Model'
}

{ #category : #visitor }
GTMessageHolder >> acceptMessageRowBrick: aGTMessageRowBrick factory: aGTCMessageFactory [ 
	aGTMessageRowBrick message: self.
	^ aGTMessageRowBrick
]

{ #category : #visitor }
GTMessageHolder >> acceptUndefinedObject: anUndefinedObject factory: aGTCMessageFactory [ 
	| aBrick |
	aBrick := aGTCMessageFactory newMessageRowBrick.
	aBrick message: self.
	^ aBrick
]

{ #category : #converting }
GTMessageHolder >> asString [
	^ self message asString
]

{ #category : #'as yet unclassified' }
GTMessageHolder >> from [
	^ self message from
]

{ #category : #accessing }
GTMessageHolder >> message [
	
	^ message
]

{ #category : #accessing }
GTMessageHolder >> message: anObject [
	
	message := anObject
]

{ #category : #printing }
GTMessageHolder >> printOn: aStream [
	aStream nextPutAll: (message printStringLimitedTo: 20)
]

{ #category : #accessing }
GTMessageHolder >> timestamp [
	^ self message timestamp
]

{ #category : #'as yet unclassified' }
GTMessageHolder >> to [
	^ self message to
]

{ #category : #ui }
GTMessageHolder >> updateBrick: aBrickOrNil factory: aGTCMessageFactory [ 
	^ aBrickOrNil visitChatterMessage: self factory: aGTCMessageFactory
]
