Extension { #name : #GLMPane }

{ #category : #'*GT-InspectorExtensions-Core' }
GLMPane class >> exampleBasic [
	<gtExample>
	^ self named: 'Basic'
]

{ #category : #'*GT-InspectorExtensions-Core' }
GLMPane >> gtInspectorPortsIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite table
		title: 'Ports';
		display: [ self ports ];
		column: 'Port' evaluated: [ :each | each name ];
		column: 'Value' evaluated: [ :each | each value asString ]
]
