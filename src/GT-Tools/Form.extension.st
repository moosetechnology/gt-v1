Extension { #name : #Form }

{ #category : #'*gt-tools' }
Form >> objectFinderFormIn: composite [
	<objectFinderPresentationOrder: 90>  
	composite morph 
		title: 'Morph';
		display: [:object | object asMorph]
]
