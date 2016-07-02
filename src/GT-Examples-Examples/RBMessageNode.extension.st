Extension { #name : #RBMessageNode }

{ #category : #'*GT-Examples-Examples' }
RBMessageNode class >> gtExampleAddition [
	<gtExample>
	^ RBMessageNode 
				receiver: (RBVariableNode named: 'self')
				selector: #+
				arguments: (Array with: (RBLiteralNode value: 0))
]
