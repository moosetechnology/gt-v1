Class {
	#name : #GTSTNamedModel,
	#superclass : #GTSTModel,
	#instVars : [
		'name'
	],
	#category : #'GT-Model'
}

{ #category : #'instance creation' }
GTSTNamedModel class >> named: aString [
	^ self named: aString environment: self defaultEnvironment
]

{ #category : #'instance creation' }
GTSTNamedModel class >> named: aString environment: anEnvironment [
	^ self new
		name: aString;
		environment: anEnvironment;
		yourself
]

{ #category : #accessing }
GTSTNamedModel >> name [
	^ name
]

{ #category : #accessing }
GTSTNamedModel >> name: anObject [
	name := anObject
]
