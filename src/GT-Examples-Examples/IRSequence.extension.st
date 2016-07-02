Extension { #name : #IRSequence }

{ #category : #'*GT-Examples-Examples' }
IRSequence class >> gtExampleSequence [
	<gtExample>
	^ (self class >> #gtExampleSequence) ast ir startSequence
]
