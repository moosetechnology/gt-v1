Extension { #name : #TGTExampleIcon }

{ #category : #'*GT-Examples-UI' }
TGTExampleIcon >> gtInspectorFormIn: composite [
	<gtInspectorPresentationOrder: 0>
	self exists ifFalse: [ ^ self ].
	
	self form gtInspectorFormIn: composite
]
