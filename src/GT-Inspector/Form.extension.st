Extension { #name : #Form }

{ #category : #'*gt-inspector' }
Form >> objectFinderFormIn: composite [
	<objectFinderPresentationOrder: 90>  
	composite morph 
		title: 'Morph';
		display: [:object | object asMorph]
]
