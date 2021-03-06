Extension { #name : #ZnMimePart }

{ #category : #'*GT-Examples-Examples' }
ZnMimePart class >> gtExampleEmptyField [
	<gtExample>
	<label: 'Empty field'>
	
	^ self fieldName: 'value' value: ''
]

{ #category : #'*GT-Examples-Examples' }
ZnMimePart class >> gtExampleField [
	<gtExample>
	<label: 'Field'>
	
	^ self fieldName: 'message' value: 'hello world'
]

{ #category : #'*GT-Examples-Examples' }
ZnMimePart class >> gtExampleFile [
	<gtExample>
	<label: 'File'>
	
	^ self 
		fieldName: 'file' 
		fileName: 'message.txt' 
		entity: (ZnEntity text: 'Hello World')
]
