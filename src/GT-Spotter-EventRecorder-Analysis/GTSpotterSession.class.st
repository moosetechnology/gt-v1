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
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each ];
		column: 'Image Hash' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each imageHash ];
		column: 'Time' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each timestamp ];
		column: 'Session Creation Time' 
			evaluated: [ :each | GTObjectPrinter new asTruncatedTextFrom: each sessionCreationTime ];
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
GTSpotterSession >> withPreviewSymbol [
	^ self isWithPreview
		ifTrue: [ 'yes' ]
		ifFalse: [ 'no' ]
]
