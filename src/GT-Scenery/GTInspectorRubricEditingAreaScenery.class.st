Class {
	#name : #GTInspectorRubricEditingAreaScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorRubricEditingAreaScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 20.0; 
		parent: #GTScenery;
		label: 'Inspector - Rubric';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorRubricEditingAreaScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: 'area := RubEditingArea new
		beWrapped;
		withoutSelectionBar;
		beForSmalltalkScripting;
		setTextWith: ''| a | 
a := 42''.
area openInWindow width: 400.
area ') .
	GTSnippets reset.
	GTSnippets snippetAt: #RubEditingArea asClass put: 'view := RTMondrian new.
self
	withDeep: [ :each |
			each allInstVars select: [ :obj | obj class name beginsWith: ''Rub'' ] ]
	do: [ :each |
			view shape label 
				text: [:x | x class name]; 
				if: [:x | x class = RubSHTextStylerST80 ] color: Color red.
			view node: each ]
	relationDo: [ :from :to | 
		view shape line color: (Color gray alpha: 0.3).
		view edges connectFrom: from to: to ].
view view edges do: #pushBack.
view layout horizontalTree.
view'
]
