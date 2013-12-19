Extension { #name : #Symbol }

{ #category : #'*gt-inspector' }
Symbol >> gtInspectorImplementorsIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite list 
		title: 'Implementors';
		display: [ self systemNavigation allImplementorsOf: self ];
		showOnly: 50
]

{ #category : #'*gt-inspector' }
Symbol >> gtInspectorSendersIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite list 
		title: 'Senders';
		display: [ self systemNavigation allSendersOf: self ];
		showOnly: 50
]
