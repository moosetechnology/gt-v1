Extension { #name : #RBProgramNode }

{ #category : #'*GT-Examples-Examples' }
RBProgramNode class >> gtExampleRBProgramNode [
	<gtExample>
	<label: 'RBProgramNode'>
	
	^ (GTInspector class >> #gtInspectorExtensionsIn:) parseTree
]
