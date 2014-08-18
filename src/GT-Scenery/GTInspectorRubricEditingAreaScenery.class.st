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
"	self cleanWindows."
	(GTPlayground openContents: 'area := RubEditingArea new
		beWrapped;
		withoutSelectionBar;
		setTextWith: ''How is this text editor structured internally?''.
area openInWindow.
area ') .
"	GTSnippets reset."
	GTSnippets snippetAt: #RubEditingArea asClass put: 'view := ROMondrianViewBuilder new.
self textArea
     withDeep: [ :each |
          (each class withAllSuperclasses) flatCollect: [ :cls |
		(cls instVarNames collect: [ :iv | each instVarNamed: iv ])
                         select: [ :obj | obj class name beginsWith: ''Rub'' ] ] ]
     do: [ :each |
          view shape label text: [:x | (x asString removePrefix: ''a '') removePrefix: ''Rub''].
          view node: each ]
     relationDo: [ :from :to | view edges: {from->to} from: from to: to ].
view layout: RTHorizontalTreeLayout new.
view'
]
