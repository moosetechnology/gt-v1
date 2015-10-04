Extension { #name : #Float }

{ #category : #'*GT-InspectorExtensions-Core' }
Float class >> gtExampleE [
	<gtExample>
	<label: 'Float with e'>
	
	^ 42.42e42
]

{ #category : #'*GT-InspectorExtensions-Core' }
Float class >> gtExampleNegativeE [
	<gtExample>
	<label: 'Float with negative e'>
	
	^ 42.42e-42
]

{ #category : #'*GT-InspectorExtensions-Core' }
Float class >> gtExampleZero [
	<gtExample>
	<label: 'Zero'>
	
	^ 0.0
]

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
	
	^ OrderedCollection
		with: '1' -> (self at: 1)
		with: '2' -> (self at: 2)
]
