Class {
	#name : #GTChildMetacellerConfiguration,
	#superclass : #GTMetacellerConfiguration,
	#instVars : [
		'model'
	],
	#category : #'GT-Metaceller-Model'
}

{ #category : #'instance creation' }
GTChildMetacellerConfiguration class >> on: aConfiguration announcer: anAnnouncer [
	^(self on: aConfiguration)
		announcer: anAnnouncer;
		yourself
]

{ #category : #'instance creation' }
GTChildMetacellerConfiguration class >> on: aConfiguration model: aModel [
	^(self on: aConfiguration)
		model: aModel;
		yourself
]

{ #category : #accessing }
GTChildMetacellerConfiguration >> announcer [
	self model ifNil: [ ^nil ].
	^ self model announcer
]

{ #category : #accessing }
GTChildMetacellerConfiguration >> model [
	^model
]

{ #category : #accessing }
GTChildMetacellerConfiguration >> model: aModel [
	self unregister.
	model := aModel.
	self register
]

{ #category : #refresh }
GTChildMetacellerConfiguration >> register [
	self announcer ifNotNil: [ self announcer on: GTConfigChanged do: [ :ann | self updateChange: ann ] ]
]

{ #category : #refresh }
GTChildMetacellerConfiguration >> unregister [
	self announcer ifNotNil: [ self announcer removeSubscriber: self ]
]

{ #category : #refresh }
GTChildMetacellerConfiguration >> updateChange: ann [
	self reset
]
