Class {
	#name : #GTSystemAnnouncer,
	#superclass : #GLMAnnouncer,
	#classInstVars : [
		'announcer',
		'categoryAnnouncer',
		'classAnnouncer',
		'protocolAnnouncer',
		'methodAnnouncer',
		'expressionAnnouncer'
	],
	#category : #'GT-Tools'
}

{ #category : #accessing }
GTSystemAnnouncer class >> announcer [
	"Answer a system annoncer."
	
	^ announcer
]

{ #category : #accessing }
GTSystemAnnouncer class >> categoryAnnouncer [
	"Answer a category annoncer."
	
	^ categoryAnnouncer
]

{ #category : #accessing }
GTSystemAnnouncer class >> classAnnouncer [
	"Answer a class annoncer."
	
	^ classAnnouncer
]

{ #category : #private }
GTSystemAnnouncer class >> event: aChangeEvent [
	announcer announce: aChangeEvent.
	aChangeEvent itemKind = #category
		ifTrue: [ ^ categoryAnnouncer announce: aChangeEvent ].
	aChangeEvent itemKind = #class
		ifTrue: [ ^ classAnnouncer announce: aChangeEvent ].
	aChangeEvent itemKind = #protocol
		ifTrue: [ ^ protocolAnnouncer announce: aChangeEvent ].
	aChangeEvent itemKind = #method
		ifTrue: [ ^ methodAnnouncer announce: aChangeEvent ].
	aChangeEvent itemKind = #expression
		ifTrue: [ ^ expressionAnnouncer announce: aChangeEvent ]
]

{ #category : #accessing }
GTSystemAnnouncer class >> expressionAnnouncer [
	"Answer a expression annoncer."
	
	^ expressionAnnouncer
]

{ #category : #initialization }
GTSystemAnnouncer class >> initialize [
	announcer := GLMAnnouncer new.
	categoryAnnouncer := GLMAnnouncer new.
	classAnnouncer := GLMAnnouncer new.
	protocolAnnouncer := GLMAnnouncer new.
	methodAnnouncer := GLMAnnouncer new.
	expressionAnnouncer := GLMAnnouncer new.
	SystemChangeNotifier uniqueInstance 
		notify: self ofAllSystemChangesUsing: #event:
]

{ #category : #accessing }
GTSystemAnnouncer class >> methodAnnouncer [
	"Answer a method annoncer."
	
	^ methodAnnouncer
]

{ #category : #accessing }
GTSystemAnnouncer class >> protocolAnnouncer [
	"Answer a protocol annoncer."
	
	^ protocolAnnouncer
]

{ #category : #initialization }
GTSystemAnnouncer class >> unload [
	SystemChangeNotifier uniqueInstance 
		noMoreNotificationsFor: self
]
