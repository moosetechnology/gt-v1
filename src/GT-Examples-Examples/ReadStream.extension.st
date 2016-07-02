Extension { #name : #ReadStream }

{ #category : #'*GT-Examples-Examples' }
ReadStream class >> gtExampleReadStream [
	<gtExample>
	<label: 'Stream'>
	
	^ 'GTInspector' readStream
]

{ #category : #'*GT-Examples-Examples' }
ReadStream class >> gtExampleReadStreamAtEnd [
	<gtExample>
	<label: 'Stream at end'>
	
	^ 'GTInspector' readStream 
		upToEnd;
		yourself
]

{ #category : #'*GT-Examples-Examples' }
ReadStream class >> gtExampleReadStreamEmpty [
	<gtExample>
	<label: 'Empty stream'>
	
	^ '' readStream
]

{ #category : #'*GT-Examples-Examples' }
ReadStream class >> gtExampleReadStreamWithPosition [
	<gtExample>
	<label: 'Stream with position'>
	
	^ 'GTInspector' readStream 
		next; 
		next; 
		yourself
]
