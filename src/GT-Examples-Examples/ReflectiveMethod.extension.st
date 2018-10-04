Extension { #name : #ReflectiveMethod }

{ #category : #'*GT-Examples-Examples' }
ReflectiveMethod class >> gtExampleMethod [
	<gtExample>
	^ self on: (self class >> #gtExampleMethod)
]
