Class {
	#name : #GTInspectorPresentationFilterStrategy,
	#superclass : #Object,
	#category : #'GT-Inspector'
}

{ #category : #accessing }
GTInspectorPresentationFilterStrategy >> changeFilterRequestFor: aGTInspector [

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
GTInspectorPresentationFilterStrategy >> openListChooseLabeled: sString forInspector: aGTInspector with: allElements select: selectedElements format: aBlockOrSelector actionSelector: aSymbol [
	|treeModel|
	
	treeModel := MorphTreeModel new.
	treeModel
		 beCheckList;
		 rootItems: allElements;
		 wrapBlockOrSelector: aBlockOrSelector;
		 autoMultiSelection: true.
	 (treeModel openDialogWindowIn: World title: sString selectedtems: selectedElements) ifNotNil: [ :selection | 
		self perform: aSymbol with: selection with: aGTInspector ]
]

{ #category : #testing }
GTInspectorPresentationFilterStrategy >> shouldDisplayPresentationCreateBy: aMethod [

	self subclassResponsibility
]
