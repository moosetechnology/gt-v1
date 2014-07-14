Extension { #name : #RBProgramNode }

{ #category : #'*GT-InspectorExtensions-Core' }
RBProgramNode >> gtInspectorSourceCodeIn: composite [
	<gtInspectorPresentationOrder: 30> 

	^ (GTSimpleRBTreeBrowser new sourceIn: composite)
		title: 'Source code';
		initialize: [ :presentation | presentation selectionInterval: self sourceInterval ]
		"populate: #selectionInterval 
			icon: GLMUIThemeExtraIcons glamorousSearch 
			entitled: 'Where is?' 
			with: [ self sourceInterval ]"
		"act: [ :presentation |
				presentation selectionInterval: self sourceInterval.
				presentation update.
				self halt.  ] 
			icon: GLMUIThemeExtraIcons glamorousSearch 
			entitled: 'Where is?'"
]

{ #category : #'*GT-InspectorExtensions-Core' }
RBProgramNode >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 30> 
	^ (GTSimpleRBTreeBrowser new treeIn: composite)
		title: 'Tree'
]
