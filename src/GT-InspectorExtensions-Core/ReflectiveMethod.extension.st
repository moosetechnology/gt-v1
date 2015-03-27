Extension { #name : #ReflectiveMethod }

{ #category : #'*GT-InspectorExtensions-Core' }
ReflectiveMethod class >> gtExampleMethod [
	<gtExample>
	^ self on: (self class >> #gtExampleMethod)
]
