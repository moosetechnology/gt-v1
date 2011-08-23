Extension { #name : #Pragma }

{ #category : #'*gt-inspector' }
Pragma class >> gtInspectorAnnotatedMethodsIn: composite [
	<gtInspectorPresentationOrder: 30> 
	composite list 
		title: 'All';
		showOnly: 50;
		withSmalltalkSearch;
		display: [:anObject | 
			| pragmas |
			pragmas := OrderedCollection new.
			Object withAllSubclassesDo: [:each |
				Pragma withPragmasIn: each do: [:p |
					pragmas add: p]].
			pragmas
		]
]
