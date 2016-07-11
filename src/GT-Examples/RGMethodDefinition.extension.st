Extension { #name : #RGMethodDefinition }

{ #category : #'*GT-Examples-Core' }
RGMethodDefinition >> asGTExampleSubject [
	^ GTExampleMethodSubject new 
		methodClassName: self realClass name;
		methodClass: self realClass;
		selector: self selector;
		ensureInitialized;
		yourself
]
