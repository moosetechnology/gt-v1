Extension { #name : #SharedQueue }

{ #category : #'*GT-Examples-Examples' }
SharedQueue class >> gtExampleBasic [
	<gtExample>
	^ self new
		nextPut: 4;
		nextPut: 2;
		yourself
]
