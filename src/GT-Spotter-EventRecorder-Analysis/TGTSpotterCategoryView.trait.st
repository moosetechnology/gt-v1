Trait {
	#name : #TGTSpotterCategoryView,
	#category : #'GT-Spotter-EventRecorder-Analysis-Traits'
}

{ #category : #enumerating }
TGTSpotterCategoryView >> categoryLabelOccurrences [
	| col |
	col := OrderedCollection new.
	self categoryLabels asBag 
		doWithOccurrences: [ :obj :occurrences | 
			col add: obj -> occurrences ].
	^ col
]

{ #category : #'gt-inspector-extension' }
TGTSpotterCategoryView >> categoryView [
	| b ds points |
	b := RTGrapher new.
	points := self categoryLabelOccurrences sortedAs: [ :x :y | x value > y value ].
	points ifEmpty: [ ^ b view ].
	b extent: ((points size * 30) min: 800) @ 150.
	ds := RTStackedDataSet new.
	ds interaction highlight.
	ds interaction popup text: [ :obj | obj key asString, ', ', obj value asString, ' times' ].
	ds points: points.
	ds barShape 
			color: (Color green alpha: 0.3); 
			width: 10.
	ds histogramWithBarTitle: #key.
	ds y: [ :obj | obj value ].
	b add: ds.
	b axisX noTick; noLabel.
	b axisY.
	b build.
	^ b view.
	
]

{ #category : #'gt-inspector-extension' }
TGTSpotterCategoryView >> gtInspectorCategoryViewIn: composite [
	<gtInspectorPresentationOrder: 6>
	composite roassal2
		title: 'Category';
		initializeView: [ self categoryView ]
		
]
