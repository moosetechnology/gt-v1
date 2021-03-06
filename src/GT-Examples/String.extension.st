Extension { #name : #String }

{ #category : #'*GT-Examples-Core' }
String >> asGTExampleSubject [
	^ GTExampleTextSubject fromString: self
]

{ #category : #'*GT-Examples-Core' }
String >> gtExampleSubstrings [
	^ ((self substrings: ' .,;') 
		collect: [ :each | each trimBoth ])
		reject: [ :each | each isEmptyOrNil ]
]
