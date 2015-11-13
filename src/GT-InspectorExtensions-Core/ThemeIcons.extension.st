Extension { #name : #ThemeIcons }

{ #category : #'*GT-InspectorExtensions-Core' }
ThemeIcons >> gtInspectorIconsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list 
		title: 'Icons';
		display: [ icons associations ];
		icon: [ :each | each value ];
		format: [ :each | each key ]
]