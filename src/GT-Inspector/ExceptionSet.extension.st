Extension { #name : #ExceptionSet }

{ #category : #'*GT-Inspector-Examples-Core' }
ExceptionSet >> copyWith: anException [
	^ self class new 
		instVarNamed: #exceptions put: (exceptions copyWith: anException);
		yourself
]

{ #category : #'*GT-Inspector-Examples-Core' }
ExceptionSet >> copyWithAll: anExceptionSet [
	^ self class new 
		instVarNamed: #exceptions put: (exceptions copyWithAll: (anExceptionSet instVarNamed: #exceptions));
		yourself
]

{ #category : #'*GT-Inspector-Examples-Core' }
ExceptionSet >> signaledBy: anException [
	(anException isNil and: [ exceptions isEmptyOrNil not ]) ifTrue: [ 
		^ (GTExampleExpectedExceptionNotRaised new 
			expectedError: self;
			exception: anException;
			yourself) signal ].
	(anException notNil and: [ (exceptions includes: anException class) not ]) ifTrue: [ 
		^ (GTExampleUnexpectedExceptionRaised new
			unexpectedError: anException;
			yourself) signal ]
]