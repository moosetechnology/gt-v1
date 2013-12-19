Extension { #name : #Symbol }

{ #category : #'*gt-inspector' }
Symbol >> gtInspectorImplementorsIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite list 
		title: 'Implementors';
		display: [ self systemNavigation allImplementorsOf: self ];
		when: [ (self systemNavigation allImplementorsOf: self) notEmpty ];
		showOnly: 30
]

{ #category : #'*gt-inspector' }
Symbol >> gtInspectorSendersIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite list 
		title: 'Senders';
		display: [ self systemNavigation allSendersOf: self ];
		when: [ (self systemNavigation allSendersOf: self) notEmpty ];
		showOnly: 30
]
