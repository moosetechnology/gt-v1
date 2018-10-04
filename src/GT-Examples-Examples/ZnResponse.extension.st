Extension { #name : #ZnResponse }

{ #category : #'*GT-Examples-Examples' }
ZnResponse class >> gtExampleGetEmpty [
	<gtExample>
	<label: 'Response: Bad request <>'>
	
	^ self badRequest: ZnRequest gtExampleGetEmpty
]

{ #category : #'*GT-Examples-Examples' }
ZnResponse class >> gtExampleGetLocalhost8080 [
	<gtExample>
	<label: 'Response: Not Found http://localhost:8080'>
	
	^ self notFound: 'http://localhost:8080'
]

{ #category : #'*GT-Examples-Examples' }
ZnResponse class >> gtExampleGetPharo [
	<gtExample>
	<label: ' Response: Created http://pharo.org'>
	
	^ self created: 'http://pharo.org'
]

{ #category : #'*GT-Examples-Examples' }
ZnResponse class >> gtExampleGetRoot [
	<gtExample>
	<label: 'Response: Redirect /'>
	
	^ self redirect: '/'
]
