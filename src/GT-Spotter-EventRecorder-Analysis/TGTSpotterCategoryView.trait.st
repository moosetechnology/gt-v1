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
	| b |
	b := RTPieBuilder new.
	b interaction popup.
	b objects: self categoryLabelOccurrences.
	b slice: #value.
	b normalizer distinctColor.
	b build.
	^ b view
]

{ #category : #'gt-inspector-extension' }
TGTSpotterCategoryView >> gtInspectorCategoryViewIn: composite [
	<gtInspectorPresentationOrder: 6>
	composite roassal2
		title: 'Category';
		initializeView: [ self categoryView ]
		
]
