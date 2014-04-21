Extension { #name : #MCPackageManager }

{ #category : #'*GT-Inspector' }
MCPackageManager class >> gtInspectorManagersIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Managers';
		display: [ self allManagers sorted: [ :x :y | x packageName < y packageName ] ];
		format: #packageName;
		filterOn: [ :text :each | each gtDisplayString includesSubstring: text caseSensitive: false ]
]
