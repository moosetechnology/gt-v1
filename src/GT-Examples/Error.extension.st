Extension { #name : #Error }

{ #category : #'*GT-Examples-Exceptions' }
Error >> asGTExamplePragmaError [
	^ GTExamplePragmaError new 
		signaledException: self;
		yourself
]

{ #category : #'*GT-Examples-Exceptions' }
Error >> isExamplesFailure [
	^ true
]
