Extension { #name : #GTExampleIcon }

{ #category : #'*GT-Examples-UI' }
GTExampleIcon >> gtInspectorFormIn: composite [
	<gtInspectorPresentationOrder: 0>
	self exists ifFalse: [ ^ self ].
	
	self form gtInspectorFormIn: composite
]
