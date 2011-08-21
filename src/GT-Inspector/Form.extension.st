Extension { #name : #Form }

{ #category : #'*gt-inspector' }
Form >> gtInspectorFormIn: composite [
	<gtInspectorPresentationOrder: 90>  
	composite morph 
		title: 'Morph';
		display: [:object | object asMorph]
]
