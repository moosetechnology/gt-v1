Extension { #name : #RGMethodDefinition }

{ #category : #'*GT-Examples-Core' }
RGMethodDefinition >> asGTExampleSubject [
	^ GTExampleMethodSubject new 
		subjectClass: self realClass;
		subjectSelector: self selector;
		yourself
]
