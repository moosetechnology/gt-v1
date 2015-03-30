Class {
	#name : #GTSpotterComputers,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #'gt-inspector-extension' }
GTSpotterComputers >> gtInspectorSessionsIn: composite [
	<gtInspectorPresentationOrder: -2>  
	^ (composite table)
		title: 'Computers';
		display: [ :aComputer | aComputer ];
		column: 'Start' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each start ] 
			width: 155;
		column: 'Duration' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each duration ] 
			width: 67;
		column: 'Sessions' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each sessions size ] 
			width: 60;
		column: 'Events' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfEvents ] 
			width: 50;
		column: 'Previews' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each numberOfPreviews ] 
			width: 50;
		showOnly: 50
]

{ #category : #enumerating }
GTSpotterComputers >> sessions [
	^ self flatCollect: #sessions as: GTSpotterSessions
]
