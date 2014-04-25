Extension { #name : #RBProgramNode }

{ #category : #'*GT-InspectorExtensions-Core' }
RBProgramNode >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 30> 
	composite custom: (GTSimpleRBTreeBrowser new  startOn: self)
]
