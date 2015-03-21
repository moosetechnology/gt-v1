Extension { #name : #RBMessageNode }

{ #category : #'*GT-InspectorExtensions-Core' }
RBMessageNode class >> exampleAddition [
	<example>
	^ RBMessageNode 
				receiver: (RBVariableNode named: 'self')
				selector: #+
				arguments: (Array with: (RBLiteralNode value: 0))
]
