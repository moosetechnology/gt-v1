Extension { #name : #IRMethod }

{ #category : #'*GT-Examples-Examples' }
IRMethod class >> gtExampleNewMethod [
	<gtExample>
	^ IRBuilder new 
		addTemps: #(a);
		pushReceiver;
		pushLiteral: 1;
		storeTemp: #a;
		ir
]

{ #category : #'*GT-Examples-Examples' }
IRMethod class >> gtExampleThisMethod [
	<gtExample>
	^ (self class >> #gtExampleThisMethod) ast ir
]
