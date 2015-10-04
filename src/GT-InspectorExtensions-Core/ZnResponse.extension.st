Extension { #name : #ZnResponse }

{ #category : #'*GT-InspectorExtensions-Core' }
ZnResponse class >> gtExampleGetEmpty [
	<gtExample>
	<label: 'Response: Bad request <>'>
	
	^ self badRequest: ZnRequest gtExampleGetEmpty
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnResponse class >> gtExampleGetLocalhost8080 [
	<gtExample>
	<label: 'Response: Not Found http://localhost:8080'>
	
	^ self notFound: 'http://localhost:8080'
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnResponse class >> gtExampleGetPharo [
	<gtExample>
	<label: ' Response: Created http://pharo.org'>
	
	^ self created: 'http://pharo.org'
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnResponse class >> gtExampleGetRoot [
	<gtExample>
	<label: 'Response: Redirect /'>
	
	^ self redirect: '/'
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnResponse >> gtInspectorResponseIn: composite [
	<gtInspectorPresentationOrder: 25>
	(self statusLine gtInspectorTextIn: composite)
		title: 'Response'
]
