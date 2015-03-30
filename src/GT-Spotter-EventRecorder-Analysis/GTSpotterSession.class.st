Class {
	#name : #GTSpotterSession,
	#superclass : #GTSpotterEventCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #'gt-inspector-extension' }
GTSpotterSession >> gtInspectorSessionsIn: composite [
	<gtInspectorPresentationOrder: -2>  
	^ (composite table)
		title: 'Events';
		display: [ :aSession | aSession ];
		column: 'Object' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ] width: 300;
		column: 'Image Hash' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each imageHash ] width: 75;
		column: 'Time' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each timestamp ] width: 155;
		column: 'Session Creation Time' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each sessionCreationTime ] width: 155;
		withSmalltalkSearch;
		helpMessage: 'Given your INPUT, it executes: self select: [:each | INPUT ]';
		showOnly: 50
]

{ #category : #accessing }
GTSpotterSession >> imageHashes [
	^ (self collect: #imageHash as: OrderedCollection) removeDuplicates
]

{ #category : #testing }
GTSpotterSession >> isWithPreview [
	^ (self contains: #isShowPreview) and: [ 
			(self contains: #isHidePreview) not ]
]

{ #category : #accessing }
GTSpotterSession >> previewString [
	^ self isWithPreview
		ifTrue: [ 'yes' ]
		ifFalse: [ 'no' ]
]

{ #category : #enumerating }
GTSpotterSession >> searchStrings [
	^ ((self select: #isContextChanged)
			flatCollect: #currentTextHashes as: Bag)
]
