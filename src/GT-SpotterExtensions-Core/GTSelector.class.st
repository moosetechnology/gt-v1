Class {
	#name : #GTSelector,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'GT-SpotterExtensions-Core'
}

{ #category : #printing }
GTSelector >> gtDisplayOn: stream [
	stream nextPutAll: self name
]

{ #category : #querying }
GTSelector >> implementors [
	^ SystemNavigation default allImplementorsOf: self name
]

{ #category : #accessing }
GTSelector >> name [
	^ name
]

{ #category : #accessing }
GTSelector >> name: anObject [
	name := anObject
]

{ #category : #querying }
GTSelector >> senders [
	^ SystemNavigation default allSendersOf: self name
]

{ #category : #ui }
GTSelector >> spotterSendersFor: aStep [
	<spotterOrder: 50>
	^ aStep listProcessor
		title: 'Senders';
		allCandidates: [ self senders collect: #compiledMethod ];
		filter: GTFilterSubstring
]
