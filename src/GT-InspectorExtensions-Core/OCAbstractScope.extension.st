Extension { #name : #OCAbstractScope }

{ #category : #'*GT-InspectorExtensions-Core' }
OCAbstractScope class >> gtExampleMethodScope [
	<gtExample>
	<label: 'Method scope'>
	
	^ (self class >> #gtExampleMethodScope) ast scope
]
