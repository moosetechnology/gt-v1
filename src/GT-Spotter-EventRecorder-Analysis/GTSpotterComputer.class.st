Class {
	#name : #GTSpotterComputer,
	#superclass : #GTSpotterEventCollection,
	#traits : 'TGTSpotterDurationView + TGTSpotterSessionsTable',
	#classTraits : 'TGTSpotterDurationView classTrait + TGTSpotterSessionsTable classTrait',
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #helpers }
GTSpotterComputer >> avgNumberOfDivesIn [
	^ (self sum: #numberOfDivesIn) / self size
]

{ #category : #helpers }
GTSpotterComputer >> avgNumberOfDivesOut [
	^ (self sum: #numberOfDivesOut) / self size
]

{ #category : #'gt-inspector-extension' }
GTSpotterComputer >> gtInspectorSessionsIn: composite [
	<gtInspectorPresentationOrder: -2>  
	^ (composite table)
		title: 'Sessions';
		display: [ :aComputer | aComputer ];
		column: 'Start' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each start ] width: 155;
		column: 'Duration' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each duration ] width: 67;
		column: 'Events' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each size ] width: 50;
		column: 'Preview' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each previewString ]
			width: 57;
		column: 'Inputs' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfContextChanged ]
			width: 47;
		column: 'Diff Inp.' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfDifferentSearchStrings ]
			width: 53;
		column: 'Fin. Searches' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfContextChanged ]
			width: 83;
		column: 'Selections' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfUserSelections ]
			width: 70;
		column: 'Dives In' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfDivesIn ]
			width: 53;
		column: 'Dives Out' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfDivesOut ]
			width: 63;
		column: 'Image Hashes' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each imageHashes size ]
			width: 70;
		showOnly: 50
]

{ #category : #helpers }
GTSpotterComputer >> numberOfDivesIn [
	^ self sum: #numberOfDivesIn
]

{ #category : #helpers }
GTSpotterComputer >> numberOfDivesOut [
	^ self sum: #numberOfDivesOut
]

{ #category : #helpers }
GTSpotterComputer >> numberOfEvents [
	^ self sum: #size
]

{ #category : #helpers }
GTSpotterComputer >> numberOfPreviews [
	^ self sessionsWithPreview size
]

{ #category : #enumerating }
GTSpotterComputer >> sessionsWithNumberOfInputsGreaterThen: anInteger [
	^ self select: [ :each | each numberOfContextChanged > anInteger ]
]

{ #category : #enumerating }
GTSpotterComputer >> sessionsWithNumberOfInputsGreaterThenOne [
	^ self sessionsWithNumberOfInputsGreaterThen: 1
]

{ #category : #enumerating }
GTSpotterComputer >> sessionsWithPreview [
	^ self select: #isWithPreview
]

{ #category : #accessing }
GTSpotterComputer >> start [
	self ifEmpty: [ ^ 0 ].
	^ self first start
]

{ #category : #accessing }
GTSpotterComputer >> stop [
	self ifEmpty: [ ^ 0 ].
	^ self first stop
]
