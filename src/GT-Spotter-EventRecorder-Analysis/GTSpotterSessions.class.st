Class {
	#name : #GTSpotterSessions,
	#superclass : #OrderedCollection,
	#traits : 'TGTSpotterDurationView + TGTSpotterUpdateEvents',
	#classTraits : 'TGTSpotterDurationView classTrait + TGTSpotterUpdateEvents classTrait',
	#category : #'GT-Spotter-EventRecorder-Analysis-Core'
}

{ #category : #accessing }
GTSpotterSessions >> duration [
	^ self end - self start
]

{ #category : #'gt-inspector-extension' }
GTSpotterSessions >> durationView [
	| b ds |
	b := RTGrapher new.
	b extent: 500 @ 100.
	self ifEmpty: [ ^ b view ].
	ds := RTStackedDataSet new.
	ds interaction highlight.
	ds interaction popup text: [ :obj | obj sessionPopupText ].
	ds points: self.
	ds barShape 
			color: [ :obj | obj isWithPreview 
				ifTrue: [ Color green alpha: 0.3 ]
				ifFalse: [ Color blue alpha: 0.3 ] ]; 
			width: 10.
	ds y: [ :c | c duration asSeconds ].
	b add: ds.
	b axisX noTick; noLabel.
	b axisY.
	b build.
	^ b view.
	
]

{ #category : #accessing }
GTSpotterSessions >> end [
	^ (self detectMax: #end)  ifNil: [ 0 ] ifNotNil: [ :obj | obj end ]
]

{ #category : #'gt-inspector-extension' }
GTSpotterSessions >> gtInspectorDurationViewIn: composite [
	<gtInspectorPresentationOrder: 5>
	composite roassal2
		title: 'Duration';
		initializeView: [ self durationView ]
		
]

{ #category : #helpers }
GTSpotterSessions >> numberOfEvents [
	^ self sum: #size
]

{ #category : #enumerating }
GTSpotterSessions >> sessions [
	^ self
]

{ #category : #accessing }
GTSpotterSessions >> start [
	^ (self detectMin: #start) ifNil: [ 0 ] ifNotNil: [ :obj | obj start ]
]
