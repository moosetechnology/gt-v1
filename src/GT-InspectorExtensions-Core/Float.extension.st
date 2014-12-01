Extension { #name : #Float }

{ #category : #'*GT-InspectorExtensions-Core' }
Float >> gtInspectorFloatIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite table
		title: 'Float';
		display: [ 
			(self respondsTo: #binaryLiteralString)
				ifTrue: [
					{'binary' -> self binaryLiteralString.
					'significand' -> self significand.
					'exponent' -> self exponent} ]
				ifFalse: [
					{'significand' -> self significand.
					'exponent' -> self exponent} ] ];
		column: 'Key' evaluated: #key;
		column: 'Value' evaluated: #value;
		send: #value
]

{ #category : #'*GT-InspectorExtensions-Core' }
Float >> gtInspectorVariableValuePairs [
	^ super gtInspectorVariableValuePairs
		add: '1' -> (self at: 1);
		add: '2' -> (self at: 2);
		yourself
]
