Extension { #name : #ZnRequest }

{ #category : #'*GT-Examples-Examples' }
ZnRequest class >> gtExampleGetEmpty [
	<gtExample>
	<label: 'Request message: GET <>'>
	
	^ self method: #GET url: ''
]

{ #category : #'*GT-Examples-Examples' }
ZnRequest class >> gtExampleGetLocalhost8080 [
	<gtExample>
	<label: 'Request message: GET http://localhost:8080'>
	
	^ self method: #GET url: 'http://localhost:8080'
]

{ #category : #'*GT-Examples-Examples' }
ZnRequest class >> gtExampleGetPharo [
	<gtExample>
	<label: 'Request message: GET http://pharo.org'>
	
	^ self method: #GET url: 'http://pharo.org'
]

{ #category : #'*GT-Examples-Examples' }
ZnRequest class >> gtExampleGetRoot [
	<gtExample>
	<label: 'Request message: GET /'>
	
	^ self method: #GET url: '/'
]
