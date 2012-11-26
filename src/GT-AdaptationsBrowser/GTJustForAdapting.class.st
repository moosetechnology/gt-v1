Class {
	#name : #GTJustForAdapting,
	#superclass : #Object,
	#instVars : [
		'anAttribute'
	],
	#classInstVars : [
		'adaptedObjects'
	],
	#category : #'GT-AdaptationsBrowser'
}

{ #category : #'as yet unclassified' }
GTJustForAdapting class >> createAdaptations [
	| anObject aMetaObject|
	
	adaptedObjects isNil ifFalse: [^ self].
	adaptedObjects := OrderedCollection new.
	
	"First Object"
	anObject := GTJustForAdapting new.
	adaptedObjects add: anObject.
	aMetaObject := BFBehavioralMetaObject new.
	aMetaObject 
		when: (BFMessageReceiveEvent new) 
		do: [:receiver :selector :arguments |  
			Transcript crShow: 'Message send: ',selector asString ].
	aMetaObject bindTo: anObject.
	
	aMetaObject := BFBehavioralMetaObject new.
	aMetaObject 
		when: (BFMessageReceiveEvent new) 
		do: [:receiver :selector :arguments |  
			Transcript crShow: 'Message send: ',selector asString ].
	aMetaObject bindTo: anObject.
	
	aMetaObject := BFBehavioralMetaObject new.
	aMetaObject 
		when: (BFVariableWriteEvent new) 
		do: [ 
			Transcript crShow: 'VariableWrite' ].
	aMetaObject bindTo: anObject.
	
	"Second object"
	anObject := GTJustForAdapting new.
	adaptedObjects add: anObject.
	aMetaObject := BFBehavioralMetaObject new.
	aMetaObject 
		when: (BFMessageReceiveEvent new) 
		do: [:receiver :selector :arguments |  
			Transcript crShow: 'Message send: ',selector asString ].
	aMetaObject bindTo: anObject.
	
	"Third object"
	aMetaObject := BFBehavioralMetaObject new.
	anObject := GTJustForAdapting new.
	adaptedObjects add: anObject.
	aMetaObject 
		when: (BFVariableWriteEvent new) 
		do: [ 
			Transcript crShow: 'VariableWrite' ].
	aMetaObject bindTo: anObject.
	
	
	
]

{ #category : #'as yet unclassified' }
GTJustForAdapting class >> removeAdaptations [

	adaptedObjects isNil ifTrue: [^ self].
	adaptedObjects do: [:anObject | BFMetaObjectContainer new unbind: anObject].
	adaptedObjects := nil.
	self recompile.
]
