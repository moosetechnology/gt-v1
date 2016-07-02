Extension { #name : #IRInstruction }

{ #category : #'*GT-Examples-Examples' }
IRInstruction class >> gtExamplePushReciever [
	<gtExample>
	^ (self class >> #gtExamplePushReciever) ast ir startSequence sequence first
]
