Extension { #name : #RBProgramNode }

{ #category : #'*gt-inspector' }
RBProgramNode >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 30> 
	composite custom: (GTSimpleParseTreeBrowser new  startOn: self)
]
