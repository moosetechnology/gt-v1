Extension { #name : #Pragma }

{ #category : #'*GT-Examples-Core' }
Pragma >> isGTExamplePragma [
	<toBeDeprecated: #gtExample:>
	^ self keyword = #gtExample
		or: [ self keyword = #gtExample: ]
]
