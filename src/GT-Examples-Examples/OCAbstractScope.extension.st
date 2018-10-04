Extension { #name : #OCAbstractScope }

{ #category : #'*GT-Examples-Examples' }
OCAbstractScope class >> gtExampleMethodScope [
	<gtExample>
	<label: 'Method scope'>
	
	^ (self class >> #gtExampleMethodScope) ast scope
]
