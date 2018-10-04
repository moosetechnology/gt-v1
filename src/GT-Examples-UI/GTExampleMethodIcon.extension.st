Extension { #name : #GTExampleMethodIcon }

{ #category : #'*GT-Examples-UI' }
GTExampleMethodIcon >> gtInspectorFormIn: composite [
	<gtInspectorPresentationOrder: 0>
	self exists ifFalse: [ ^ self ].
	
	self form gtInspectorFormIn: composite
]
