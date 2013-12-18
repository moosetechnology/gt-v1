Extension { #name : #GLMSystemWindow }

{ #category : #'*gt-inspector' }
GLMSystemWindow >> gtInspectorOpenTreeIn: composite [
	<gtInspectorPresentationOrder: 30>  
	^ (self model 
		gtInspectorOpenTreeIn: composite)
		title: 'Browser tree'
]
