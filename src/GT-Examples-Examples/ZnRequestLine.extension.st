Extension { #name : #ZnRequestLine }

{ #category : #'*GT-Examples-Examples' }
ZnRequestLine class >> gtExampleGetEmpty [
	<gtExample>
	<label: 'Request line: GET <>'>
	
	^ self method: #GET uri: ''
]

{ #category : #'*GT-Examples-Examples' }
ZnRequestLine class >> gtExampleGetLocalhost8080 [
	<gtExample>
	<label: 'Request line: GET http://localhost:8080'>
	
	^ self method: #GET uri: 'http://localhost:8080'
]

{ #category : #'*GT-Examples-Examples' }
ZnRequestLine class >> gtExampleGetPharo [
	<gtExample>
	<label: 'Request line: GET http://pharo.org'>
	
	^ self method: #GET uri: 'http://pharo.org'
]

{ #category : #'*GT-Examples-Examples' }
ZnRequestLine class >> gtExampleGetRoot [
	<gtExample>
	<label: 'Request line: GET /'>
	
	^ self method: #GET uri: '/'
]
