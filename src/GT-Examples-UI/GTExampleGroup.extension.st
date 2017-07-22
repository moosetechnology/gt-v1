Extension { #name : #GTExampleGroup }

{ #category : #'*GT-Examples-UI' }
GTExampleGroup >> gtInspectorExamplesIn: composite [
	<gtInspectorPresentationOrder: 1>
	composite fastTable
		title: 'Examples';
		display: [ self examples ];
		column: 'Name' evaluated: [ :each | each gtDisplayString ];
		column: 'Selector' evaluated: [ :each | each selector ];
		column: 'Class' evaluated: [ :each | each methodClass instanceSide name ]
]
