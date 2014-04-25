Extension { #name : #GLMSystemWindow }

{ #category : #'*GT-InspectorExtensions-Core' }
GLMSystemWindow >> gtInspectorOpenTreeIn: composite [
	<gtInspectorPresentationOrder: 30>  
	^ (self model 
		gtInspectorOpenTreeIn: composite)
		title: 'Browser tree'
]
