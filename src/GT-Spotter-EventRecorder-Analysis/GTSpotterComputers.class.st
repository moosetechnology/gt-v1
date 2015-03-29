Class {
	#name : #GTSpotterComputers,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #'as yet unclassified' }
GTSpotterComputers >> gtInspectorSessionsIn: composite [
	<gtInspectorPresentationOrder: -2>  
	^ (composite table)
		title: 'Computers';
		display: [ :aComputer | aComputer ];
		column: 'Start' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each start ];
		column: 'Duration' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each duration ];
		column: 'Events' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each size ];
		column: 'Sessions' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each sessions size ];
		showOnly: 50
]

{ #category : #enumerating }
GTSpotterComputers >> sessions [
	^ self flatCollect: #sessions as: GTSpotterSessions
]
