Class {
	#name : #GTSpotterEventCollection,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #enumerating }
GTSpotterEventCollection >> divesIn [
	^ self select: #isDiveIn
]

{ #category : #enumerating }
GTSpotterEventCollection >> divesOut [
	^ self select: #isDiveOut
]

{ #category : #accessing }
GTSpotterEventCollection >> duration [
	^ self stop - self start
]

{ #category : #helpers }
GTSpotterEventCollection >> numberOfDivesIn [
	^ self divesIn size
]

{ #category : #helpers }
GTSpotterEventCollection >> numberOfDivesOut [
	^ self divesOut size
]

{ #category : #helpers }
GTSpotterEventCollection >> numberOfUserSelections [
	^ self userSelections size
]

{ #category : #printing }
GTSpotterEventCollection >> sessionPopupText [
	^ String streamContents: [ :aStream |
			aStream
				nextPutAll: 'Duration: ';
				print: self duration;
				cr;
				nextPutAll: 'Events: ';
				print: self size;
				cr;
				nextPutAll: 'Dive in/out: ';
				print: self numberOfDivesIn;
				nextPut: $/;
				print: self numberOfDivesOut;
				cr;
				nextPutAll: 'Number of user item selections: ';
				print: self numberOfUserSelections;
				cr;
				"add number of context changed,
				number of different searched string
				using of #i, etc."
				nextPutAll: (self isWithPreview ifTrue: [ 'With Preview' ] ifFalse: [ 'Without Preview' ])
		 ]
]

{ #category : #accessing }
GTSpotterEventCollection >> start [
	^ self first timestamp
]

{ #category : #accessing }
GTSpotterEventCollection >> stop [
	^ self last timestamp
]

{ #category : #enumerating }
GTSpotterEventCollection >> userSelections [
	^ self select: #isUserSelection
]
