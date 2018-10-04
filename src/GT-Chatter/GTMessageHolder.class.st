Class {
	#name : #GTMessageHolder,
	#superclass : #Object,
	#instVars : [
		'contents'
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
	^ self contents asString
]

{ #category : #accessing }
GTMessageHolder >> contents [
	^ contents
]

{ #category : #accessing }
GTMessageHolder >> contents: anObject [
	contents := anObject
]

{ #category : #accessing }
GTMessageHolder >> from [
	^ self contents from
]

{ #category : #printing }
GTMessageHolder >> printOn: aStream [
	aStream nextPutAll: (contents printStringLimitedTo: 20)
]

{ #category : #accessing }
GTMessageHolder >> timestamp [
	^ self contents timestamp
]

{ #category : #accessing }
GTMessageHolder >> to [
	^ self contents to
]

{ #category : #ui }
GTMessageHolder >> updateBrick: aBrickOrNil factory: aGTCMessageFactory [ 
	^ aBrickOrNil visitChatterMessage: self factory: aGTCMessageFactory
]
