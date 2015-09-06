Extension { #name : #ZnHeaders }

{ #category : #'*GT-InspectorExtensions-Core' }
ZnHeaders class >> gtExampleDefaultRequestHeaders [
	<gtExample>
	<label: 'Default request headers'>
	
	^ self defaultRequestHeaders
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnHeaders class >> gtExampleDefaultResponseHeaders [
	<gtExample>
	<label: 'Default response headers'>
	
	^ self defaultResponseHeaders
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnHeaders >> gtInspectorHeadersIn: composite [ 
	<gtInspectorPresentationOrder: 30>
	^ (self headers gtInspectorItemsIn: composite) 
		display: [ :anObject | self headers associations ];
		title: [ :anObject | self headers size asString , ' items' ]
]
