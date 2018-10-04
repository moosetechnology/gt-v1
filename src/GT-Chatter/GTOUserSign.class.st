Class {
	#name : #GTOUserSign,
	#superclass : #Object,
	#instVars : [
		'nickname'
	],
	#category : #'GT-Chatter-NewModel'
}

{ #category : #comparing }
GTOUserSign >> = anObject [
	^ self == anObject or: [ 
		 self class = anObject class and: [ 
			self nickname = anObject nickname ] ]
]

{ #category : #comparing }
GTOUserSign >> hash [
	^ self nickname hash
]

{ #category : #accessing }
GTOUserSign >> nickname [
	^ nickname
]

{ #category : #accessing }
GTOUserSign >> nickname: anObject [
	self assert: anObject isString.
	nickname := anObject
]

{ #category : #printing }
GTOUserSign >> printOn: aStream [
	self nickname 
		ifNil: [ aStream nextPutAll: 'a user' ]
		ifNotNil: [ aStream print: self nickname ].
]
