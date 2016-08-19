Extension { #name : #GTAbstractExampleIcon }

{ #category : #'*GT-Examples-UI' }
GTAbstractExampleIcon >> gtInspectorFormIn: composite [
	<gtInspectorPresentationOrder: 0>
	self exists ifFalse: [ ^ self ].
	
	self form gtInspectorFormIn: composite
]
