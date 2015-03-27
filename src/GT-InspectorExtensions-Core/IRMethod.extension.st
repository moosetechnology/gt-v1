Extension { #name : #IRMethod }

{ #category : #'*GT-InspectorExtensions-Core' }
IRMethod class >> gtExampleNewMethod [
	<gtExample>
	^ IRBuilder new 
		addTemps: #(a);
		pushReceiver;
		pushLiteral: 1;
		storeTemp: #a;
		ir
]

{ #category : #'*GT-InspectorExtensions-Core' }
IRMethod class >> gtExampleThisMethod [
	<gtExample>
	^ (self class >> #gtExampleThisMethod) ast ir
]
