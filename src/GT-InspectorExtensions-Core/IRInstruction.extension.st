Extension { #name : #IRInstruction }

{ #category : #'*GT-InspectorExtensions-Core' }
IRInstruction class >> gtExamplePushReciever [
	<gtExample>
	^ (self class >> #gtExamplePushReciever) ast ir startSequence sequence first
]
