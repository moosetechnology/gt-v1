Extension { #name : #Object }

{ #category : #'*GT-Examples-Core' }
Object >> asGTExampleSubject [
	^ GTExampleInstanceSubject fromObject: self
]

{ #category : #'*GT-Examples-Core' }
Object class >> gtExampleContext [
	^ GTCurrentExampleContext value
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
