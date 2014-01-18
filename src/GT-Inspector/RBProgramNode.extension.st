Extension { #name : #RBProgramNode }

{ #category : #'*gt-inspector' }
RBProgramNode >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 30> 
	composite custom: (GTSimpleRBTreeBrowser new  startOn: self)
]
