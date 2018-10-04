Extension { #name : #DBXRow }

{ #category : #'*GT-InspectorExtensions-DBXTalk' }
DBXRow >> gtInspectorValuesIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite table
		title: 'Values';
		display: [ self resultSet columnDescriptions collect: [ :each | 
				each -> (self valueNamed: each name) ] ];
		column: 'Column' evaluated: [ :each | each key name ];
		column: 'Value' evaluated: [ :each | each value ];
		send: [ :each | each value ]
]
