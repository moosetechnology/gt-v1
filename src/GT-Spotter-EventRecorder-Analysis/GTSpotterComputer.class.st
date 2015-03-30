Class {
	#name : #GTSpotterComputer,
	#superclass : #GTSpotterEventCollection,
	#traits : 'TGTSpotterDurationView + TGTSpotterSessionsTable',
	#classTraits : 'TGTSpotterDurationView classTrait + TGTSpotterSessionsTable classTrait',
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #'gt-inspector-extension' }
GTSpotterComputer >> gtInspectorSessionsIn: composite [
	<gtInspectorPresentationOrder: -2>  
	^ (composite table)
		title: 'Sessions';
		display: [ :anEvent | anEvent sessions ];
		column: 'Start' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each start ] width: 155;
		column: 'Duration' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each duration ] width: 67;
		column: 'Events' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each size ] width: 50;
		column: 'Preview' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each withPreviewSymbol ]
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

{ #category : #'as yet unclassified' }
GTSpotterComputer >> numberOfEvents [
	^ self sum: #size
]

{ #category : #'as yet unclassified' }
GTSpotterComputer >> numberOfPreviews [
	^ self sessionsWithPreview size
]

{ #category : #'as yet unclassified' }
GTSpotterComputer >> sessions [
	^ self
]

{ #category : #'as yet unclassified' }
GTSpotterComputer >> sessionsWithPreview [
	^ self select: #isWithPreview
]

{ #category : #'as yet unclassified' }
GTSpotterComputer >> start [
	self ifEmpty: [ ^ 0 ].
	^ self first start
]

{ #category : #'as yet unclassified' }
GTSpotterComputer >> stop [
	self ifEmpty: [ ^ 0 ].
	^ self first stop
]
