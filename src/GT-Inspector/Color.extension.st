Extension { #name : #Color }

{ #category : #'*gt-inspector' }
Color >> gtInspectorColorIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite morph 
		title: 'Color';
		display: [ BorderedMorph new color: self ]
]
