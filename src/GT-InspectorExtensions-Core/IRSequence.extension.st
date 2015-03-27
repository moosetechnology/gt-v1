Extension { #name : #IRSequence }

{ #category : #'*GT-InspectorExtensions-Core' }
IRSequence class >> gtExampleSequence [
	<gtExample>
	^ (self class >> #gtExampleSequence) ast ir startSequence
]
