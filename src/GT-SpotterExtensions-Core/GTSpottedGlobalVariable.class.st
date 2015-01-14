"
A GTSpottedGlobalVars is a wrapper around names (Symbols) that exist in Smalltalks global dictionary and refers to global objects, like ActiveHand, Display).

And of course, you can spot the users of this global var and spot the class of the object.
"
Class {
	#name : #GTSpottedGlobalVariable,
	#superclass : #Object,
	#instVars : [
		'varName'
	],
	#category : #'GT-SpotterExtensions-Core'
}

{ #category : #globals }
GTSpottedGlobalVariable class >> all [
	^ (Smalltalk globals associationsSelect:[:assoc | 
			assoc value isBehavior not and:[ 
				assoc value isTrait not]]) 
			keys collect:[:key | GTSpottedGlobalVariable on: key]
]

{ #category : #'instance creation' }
GTSpottedGlobalVariable class >> on: aKey [
	^ self new varName: aKey; yourself
]

{ #category : #accessing }
GTSpottedGlobalVariable >> globalValue [
	^ Smalltalk at: self varName
]

{ #category : #'as yet unclassified' }
GTSpottedGlobalVariable >> spotterActDefault [
	self globalValue inspect
]

{ #category : #'as yet unclassified' }
GTSpottedGlobalVariable >> spotterClassFor: aStep [
	<spotterOrder: 50>
	aStep listProcessor
			title: 'Class';
			allCandidates: [ { self globalValue class }];
			itemIcon: #systemIcon;
			matchSubstring
]

{ #category : #'as yet unclassified' }
GTSpottedGlobalVariable >> spotterReferenceFor: aStep [
	<spotterOrder: 130>
	aStep listProcessor
			title: 'References';
			allCandidates: [ (SystemNavigation default allReferencesTo: self varBinding) collect: #compiledMethod ];
			itemName: [ :method | method gtDisplayString ];
			matchSubstring
]

{ #category : #accessing }
GTSpottedGlobalVariable >> varBinding [
	^ Smalltalk bindingOf: self varName.
]

{ #category : #accessing }
GTSpottedGlobalVariable >> varName [
	^ varName
]

{ #category : #accessing }
GTSpottedGlobalVariable >> varName: anObject [
	varName := anObject
]
