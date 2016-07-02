Extension { #name : #BlockClosure }

{ #category : #'*GT-Examples-Examples' }
BlockClosure class >> gtExampleEmpty [
	<gtExample>
	<label: 'Empty'>
	
	^ [  ]
]

{ #category : #'*GT-Examples-Examples' }
BlockClosure class >> gtExampleOneArgument [
	<gtExample>
	<label: 'With one argument'>
	
	^ [ :x | x ]
]

{ #category : #'*GT-Examples-Examples' }
BlockClosure class >> gtExampleTwoArguments [
	<gtExample>
	<label: 'With two arguments'>
	
	^ [ :x :y | x + y ]
]
