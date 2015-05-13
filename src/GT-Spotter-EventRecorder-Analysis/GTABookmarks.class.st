Class {
	#name : #GTABookmarks,
	#superclass : #OrderedCollection,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #cleanup }
GTABookmarks class >> cleanUp [
	self reset
]

{ #category : #'as yet unclassified' }
GTABookmarks class >> from: aCollection [ 
	^ aCollection collect: [ :each | GTABookmark from: each ]
]

{ #category : #accessing }
GTABookmarks class >> reset [
	uniqueInstance := nil
]

{ #category : #accessing }
GTABookmarks class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #'as yet unclassified' }
GTABookmarks class >> uniqueInstanceFrom: aCollection [ 
	uniqueInstance := self from: aCollection
]

{ #category : #'as yet unclassified' }
GTABookmarks >> addSession: aGTASession description: aString [ 
	^ self add: (GTASessionBookmark new item: aGTASession; description: aString; yourself)
]
