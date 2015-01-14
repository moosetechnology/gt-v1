"
A GTInspectorPresentationFilterStrategy is the root class for filters that can limit the number if visible presentations for an object.

Subclasses need to implement  #shouldDisplayPresentationCreateBy: to indicate whether or not a give presentation should be displayed.

"
Class {
	#name : #GTInspectorPresentationFilterStrategy,
	#superclass : #Object,
	#category : #'GT-Inspector'
}

{ #category : #accessing }
GTInspectorPresentationFilterStrategy >> changeFilterRequestFor: aGTInspector [

	self subclassResponsibility
]

{ #category : #private }
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
