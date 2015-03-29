Class {
	#name : #GTSpotterSessions,
	#superclass : #OrderedCollection,
	#category : #'GT-Spotter-EventRecorder-Analysis'
}

{ #category : #'gt-inspector-extension' }
GTSpotterSessions >> durationView [
	| b ds |
	b := RTGrapher new.
	b extent: 500 @ 100.
	ds := RTStackedDataSet new.
	ds points: self.
	ds x: #timestamp.
	ds y: [ :c | c duration asSeconds ].
	ds dotShape rectangle color: Color green.
	ds barShape color: Color blue; width: 10.
	b add: ds.
	b axisX.
	b axisY.
	b axisYWithNumberOfTicks: 4.
	b build.
	^ b view.
	
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
