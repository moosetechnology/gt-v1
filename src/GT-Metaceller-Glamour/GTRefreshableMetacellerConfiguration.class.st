Class {
	#name : #GTRefreshableMetacellerConfiguration,
	#superclass : #GTMetacellerConfiguration,
	#instVars : [
		'announcer'
	],
	#category : #'GT-Metaceller-Glamour'
}

{ #category : #'instance creation' }
GTRefreshableMetacellerConfiguration class >> on: aConfiguration announcer: anAnnouncer [
	^(self on: aConfiguration)
		announcer: anAnnouncer;
		yourself
]

{ #category : #accessing }
GTRefreshableMetacellerConfiguration >> announcer [
	^ announcer
]

{ #category : #accessing }
GTRefreshableMetacellerConfiguration >> announcer: anObject [
	self unregister.
	announcer := anObject.
	self register
]

{ #category : #refresh }
GTRefreshableMetacellerConfiguration >> register [
	self announcer ifNotNil: [ self announcer on: GTConfigChanged do: [ :ann | self updateChange: ann ] ]
]

{ #category : #refresh }
GTRefreshableMetacellerConfiguration >> unregister [
	self announcer ifNotNil: [ self announcer removeSubscriber: self ]
]

{ #category : #refresh }
GTRefreshableMetacellerConfiguration >> updateChange: ann [
	self reset
]
