Extension { #name : #ContextPart }

{ #category : #'*gt-debugger' }
ContextPart >> isHaltContext [

	^ self method selector = #halt
]
