Extension { #name : #GTExample }

{ #category : #'*GT-InspectorExtensions-Core' }
GTExample classSide >> gtExampleBasic [
	<gtExample>
	^ self new
		provider: self;
		selector: #gtExampleBasic
]

{ #category : #'*GT-InspectorExtensions-Core' }
GTExample >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ self gtDisplaySourceIn: composite
]
