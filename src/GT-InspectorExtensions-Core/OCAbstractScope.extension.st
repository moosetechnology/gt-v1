Extension { #name : #OCAbstractScope }

{ #category : #'*GT-InspectorExtensions-Core' }
OCAbstractScope class >> gtExampleMethodScope [
	<gtExample: 'Method scope'>
	^ (self class >> #gtExampleMethodScope) ast scope
]
