Extension { #name : #Morph }

{ #category : #'*gt-inspector' }
Morph >> gtInspectorMorphIn: composite [
	<gtInspectorPresentationOrder: 90>  
	composite morph 
		title: 'Morph';
		display: [:each | each imageForm asMorph ]
]

{ #category : #'*gt-inspector' }
Morph >> gtInspectorSubmorphsIn: composite [
	<gtInspectorPresentationOrder: 80>  
	composite tree 
		title: 'Submorphs';
		rootsExpanded;
		display: [:each | {each} ];
		children: [:each | each submorphs]
]
