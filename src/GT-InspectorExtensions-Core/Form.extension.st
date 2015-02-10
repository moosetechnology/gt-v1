Extension { #name : #Form }

{ #category : #'*GT-InspectorExtensions-Core' }
Form class >> gtExampleEmptyForm32x32 [
	<example: 'Empty Form 32x32'>
	^ Form extent: 32@32
]

{ #category : #'*GT-InspectorExtensions-Core' }
Form >> gtInspectorFormIn: composite [
	<gtInspectorPresentationOrder: 90>  
	^ composite morph 
		title: 'Morph';
		display: [ self asMorph ]
]
