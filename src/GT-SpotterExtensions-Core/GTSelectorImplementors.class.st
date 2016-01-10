Class {
	#name : #GTSelectorImplementors,
	#superclass : #Object,
	#instVars : [
		'name',
		'methods'
	],
	#category : #'GT-SpotterExtensions-Core'
}

{ #category : #examples }
GTSelectorImplementors class >> gtExampleNew [
	<gtExample>
	^ self new name: #new
]

{ #category : #accessing }
GTSelectorImplementors >> addMethod: aCompiledMethod [
	methods add: aCompiledMethod
]

{ #category : #printing }
GTSelectorImplementors >> gtDisplayOn: stream [
	stream nextPutAll: self name
]

{ #category : #querying }
GTSelectorImplementors >> implementors [
	^ SystemNavigation default allImplementorsOf: self name
]

{ #category : #initialization }
GTSelectorImplementors >> initialize [
	super initialize.
	
	methods := OrderedCollection new.
]

{ #category : #accessing }
GTSelectorImplementors >> name [
	^ name
]

{ #category : #accessing }
GTSelectorImplementors >> name: anObject [
	name := anObject
]

{ #category : #querying }
GTSelectorImplementors >> senders [
	^ SystemNavigation default allSendersOf: self name
]

{ #category : #ui }
GTSelectorImplementors >> spotterImplementorsFor: aStep [
	<spotterOrder: 50>
	^ aStep listProcessor
		title: 'Implementors';
		filter: GTFilterSubstring item: [ :filter :context | methods do: filter ]
]

{ #category : #ui }
GTSelectorImplementors >> spotterSendersFor: aStep [
	<spotterOrder: 50>
	^ aStep listProcessor
		title: 'Senders';
		filter: GTFilterSubstring item: [ :filter :context | 
			self senders do: [ :sender | 
				filter value: sender compiledMethod ] ]
]
