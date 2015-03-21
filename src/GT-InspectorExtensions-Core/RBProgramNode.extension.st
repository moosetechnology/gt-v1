Extension { #name : #RBProgramNode }

{ #category : #'*GT-InspectorExtensions-Core' }
RBProgramNode >> gtInspectorSourceCodeIn: composite [
	<gtInspectorPresentationOrder: 30> 

	^ composite smalltalkCode 
		title: 'Source code';
		display: [ self source ];
		initialize: [ :presentation | 
			presentation selectionInterval: self sourceInterval ];
		act: [ self methodNode method compiledMethod browse ] icon: GLMUIThemeExtraIcons glamorousBrowse entitled: 'Browse'
]

{ #category : #'*GT-InspectorExtensions-Core' }
RBProgramNode >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 30> 
	^ (GTSimpleRBTreeBrowser new treeIn: composite)
		title: 'Tree'
]
