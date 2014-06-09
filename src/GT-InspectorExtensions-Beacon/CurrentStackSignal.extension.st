Extension { #name : #CurrentStackSignal }

{ #category : #'*GT-InspectorExtensions-Beacon' }
CurrentStackSignal >> gtInspectorStackIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list 
		title: 'Stack';
		display: [ self stack ]
]
