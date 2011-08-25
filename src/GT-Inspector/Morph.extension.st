Extension { #name : #Morph }

{ #category : #'*gt-inspector' }
Morph >> gtInspectorMorphIn: composite [
	<gtInspectorPresentationOrder: 90>  
	composite morph 
		title: 'Morph';
		display: [:each | each imageForm asMorph ]
]
