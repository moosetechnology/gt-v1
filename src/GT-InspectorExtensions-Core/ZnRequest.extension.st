Extension { #name : #ZnRequest }

{ #category : #'*GT-InspectorExtensions-Core' }
ZnRequest class >> gtExampleGetEmpty [
	<gtExample: 'Request message: GET <>'>
	^ self method: #GET url: ''
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnRequest class >> gtExampleGetLocalhost8080 [
	<gtExample: 'Request message: GET http://localhost:8080'>
	^ self method: #GET url: 'http://localhost:8080'
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnRequest class >> gtExampleGetPharo [
	<gtExample: 'Request message: GET http://pharo.org'>
	^ self method: #GET url: 'http://pharo.org'
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnRequest class >> gtExampleGetRoot [
	<gtExample: 'Request message: GET /'>
	^ self method: #GET url: '/'
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnRequest >> gtInspectorRequestIn: composite [
	<gtInspectorPresentationOrder: 25>
	(self requestLine gtInspectorTextIn: composite)
		title: 'Request'
]
