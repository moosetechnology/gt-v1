Extension { #name : #GTExample }

{ #category : #'*GT-Examples-Roassal2' }
GTExample >> gtInspectorRoassalIn: composite [
	<gtInspectorPresentationOrder: 1>
	self hasDependencies ifFalse: [ ^ self ].
	^ composite roassal2
		title: 'Graph';
		painting: [ :view :example | 
			(GTExampleGraphPainter new 
				example: example;
				view: view;
				yourself) paint ];
		yourself
]
