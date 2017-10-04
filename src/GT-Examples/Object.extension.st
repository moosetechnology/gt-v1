Extension { #name : #Object }

{ #category : #'*GT-Examples-Core' }
Object >> asGTExampleSubject [
	^ self class gtExamplesFactoryClass instanceSubjectFromObject: self
]

{ #category : #'*GT-Examples-Core' }
Object >> assert: actual equals: expected [
	self assert: actual = expected
]

{ #category : #'*GT-Examples-Core' }
Object class >> gtExampleContext [
	^ self gtExamplesFactoryClass gtExampleContext
]

{ #category : #'*GT-Examples-Core' }
Object >> gtExampleContext [
	^ self class gtExampleContext
]

{ #category : #'*GT-Examples-Core' }
Object >> gtExampleSubstrings [
	^ {  }
]

{ #category : #'*GT-Examples-Core' }
Object >> gtExamples [
	^ self class gtExamples
]

{ #category : #'*GT-Examples-Core' }
Object >> gtExamplesContained [
	^ self gtExamples
]

{ #category : #'*GT-Examples-Core' }
Object >> gtExamplesFactory [
	^ self class gtExamplesFactory
]

{ #category : #'*GT-Examples-Core' }
Object >> gtExamplesSubjects [
	^ {  }
]

{ #category : #'*GT-Examples-Core' }
Object >> isGTExample [
	^ false
]

{ #category : #'*GT-Examples-Exceptions' }
Object >> isGTExampleError [
	^ false
]

{ #category : #'*GT-Examples-Core' }
Object >> isGTExampleMethod [
	^ false
]
