Extension { #name : #RGMethodDefinition }

{ #category : #'*GT-Examples-Core' }
RGMethodDefinition >> asGTExampleSubject [
	^ GTExampleMethodSubject fromClass: self realClass selector: self selector
]
