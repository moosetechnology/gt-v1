Class {
	#name : #GTSpotterEventCollection,
	#superclass : #OrderedCollection,
	#instVars : [
		'options'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #enumerating }
GTSpotterEventCollection >> contextChanges [
	^ self select: #isContextChanged
]

{ #category : #enumerating }
GTSpotterEventCollection >> differentSearchStrings [
	^ self searchStrings asSet
]

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

{ #category : #enumerating }
GTSpotterEventCollection >> finishedSearches [
	^ self select: #isSearchFinished
]

{ #category : #testing }
GTSpotterEventCollection >> hasMissSteps [
	^ self missSteps notEmpty
]

{ #category : #helpers }
GTSpotterEventCollection >> numberOfContextChanged [
	^ self contextChanges size
]

{ #category : #helpers }
GTSpotterEventCollection >> numberOfDifferentSearchStrings [
	^ self differentSearchStrings size
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
GTSpotterEventCollection >> numberOfFinishedSearches [
	^ self finishedSearches size
]

{ #category : #helpers }
GTSpotterEventCollection >> numberOfMissSteps [
	^ self missSteps size
]

{ #category : #helpers }
GTSpotterEventCollection >> numberOfUserSelections [
	^ self userSelections size
]

{ #category : #accessing }
GTSpotterEventCollection >> optionAt: key [
	^ self optionAt: key ifAbsent: [ nil ]
]

{ #category : #accessing }
GTSpotterEventCollection >> optionAt: key ifAbsent: absentBlock [
	options ifNil: [ ^ absentBlock value ].
	^ options at: key ifAbsent: absentBlock
]

{ #category : #accessing }
GTSpotterEventCollection >> optionAt: key put: value [
	options ifNil: [ options := Dictionary new ].
	^ options at: key put: value
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
				nextPutAll: 'Number of user input changes: ';
				print: self numberOfContextChanged;
				cr;
				nextPutAll: 'Number of different search strings: ';
				print: self numberOfDifferentSearchStrings;
				cr;
				nextPutAll: 'Number of finished searches: ';
				print: self numberOfFinishedSearches;
				cr;
				nextPutAll: 'Number of user item selections: ';
				print: self numberOfUserSelections;
				cr;
				nextPutAll: 'Dive in/out: ';
				print: self numberOfDivesIn;
				nextPut: $/;
				print: self numberOfDivesOut;
				cr;
				"using of #i, etc."
				nextPutAll: (self isWithPreview ifTrue: [ 'With Preview' ] ifFalse: [ 'Without Preview' ])
		 ]
]

{ #category : #enumerating }
GTSpotterEventCollection >> userSelections [
	^ self select: #isUserSelection
]
