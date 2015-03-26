Extension { #name : #RBMessageNode }

{ #category : #'*GT-InspectorExtensions-Core' }
RBMessageNode class >> exampleAddition [
	<gtExample>
	^ RBMessageNode 
				receiver: (RBVariableNode named: 'self')
				selector: #+
				arguments: (Array with: (RBLiteralNode value: 0))
]
