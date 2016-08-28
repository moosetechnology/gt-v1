Extension { #name : #GTPlayground }

{ #category : #'*GT-Examples-UI' }
GTPlayground class >> menuFor: aPlayground [
	<playgroundContextMenu>
	^ GTExamplePlaygroundMenu menuFor: aPlayground
]
