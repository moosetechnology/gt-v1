Extension { #name : #ZnRequestLine }

{ #category : #'*GT-InspectorExtensions-Core' }
ZnRequestLine class >> gtExampleGetEmpty [
	<gtExample>
	<label: 'Request line: GET <>'>
	
	^ self method: #GET uri: ''
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnRequestLine class >> gtExampleGetLocalhost8080 [
	<gtExample>
	<label: 'Request line: GET http://localhost:8080'>
	
	^ self method: #GET uri: 'http://localhost:8080'
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnRequestLine class >> gtExampleGetPharo [
	<gtExample>
	<label: 'Request line: GET http://pharo.org'>
	
	^ self method: #GET uri: 'http://pharo.org'
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnRequestLine class >> gtExampleGetRoot [
	<gtExample>
	<label: 'Request line: GET /'>
	
	^ self method: #GET uri: '/'
]

{ #category : #'*GT-InspectorExtensions-Core' }
ZnRequestLine >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite text
		title: 'HTTP';
		format: [ String streamContents: [ :out | self writeOn: out ] ]
]
