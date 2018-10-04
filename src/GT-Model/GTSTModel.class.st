Class {
	#name : #GTSTModel,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'GT-Model'
}

{ #category : #defaults }
GTSTModel class >> defaultEnvironment [
	^ BrowserEnvironment new
]

{ #category : #accessing }
GTSTModel >> = anObject [
	^ self class = anObject class and: [self name = anObject name ]
]

{ #category : #accessing }
GTSTModel >> environment [
	^ environment ifNil: [environment := self class defaultEnvironment]
]

{ #category : #accessing }
GTSTModel >> environment: anObject [
	environment := anObject
]

{ #category : #testing }
GTSTModel >> isCategory [
	^ false
]

{ #category : #testing }
GTSTModel >> isClass [
	^ false
]

{ #category : #testing }
GTSTModel >> isClassCategory [
	^ false
]

{ #category : #testing }
GTSTModel >> isMethod [
	^ false
]

{ #category : #accessing }
GTSTModel >> name [
	self subclassResponsibility
]

{ #category : #printing }
GTSTModel >> printOn: aStream [
	aStream nextPutAll: self name
]
