Extension { #name : #Pragma }

{ #category : #'*GT-Inspector-Examples-Core' }
Pragma >> isGTExamplePragma [
	<todo: 'deprecated: #gtExample:'>
	^ self keyword = #gtExample
		or: [ self keyword = #gtExample: ]
]
