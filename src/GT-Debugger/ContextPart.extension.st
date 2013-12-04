Extension { #name : #ContextPart }

{ #category : #'*gt-debugger' }
ContextPart >> findContextMatchingPredicate: aPredicate [
	^ self findContextSuchThat: [ :ctx |
		aPredicate matches: ctx ]
]

{ #category : #'*gt-debugger' }
ContextPart >> isHaltContext [

	^ self method selector = #halt
]
