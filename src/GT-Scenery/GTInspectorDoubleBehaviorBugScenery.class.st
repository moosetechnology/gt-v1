Class {
	#name : #GTInspectorDoubleBehaviorBugScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorDoubleBehaviorBugScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 30.0; 
		parent: #GTScenery;
		label: 'Inspector - Duplicated behavior bug';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorDoubleBehaviorBugScenery >> setUp [
	self cleanWindows.
	GLMMorphicFTRenderer compile: 'dataSourceUpdated: announcement
	tableModel ifNotNil: [ self unsubscribeDataSource: tableModel ].
	tableModel := announcement newDataSource.
	self installActionsOnModel: tableModel fromPresentation: tableModel glamourPresentation.
	self initializeAnnouncementForDataSource'.
	
	(GTPlayground openContents: '1/0.
InMemoryLogger start.
InMemoryLogger instance.
InMemoryLogger stop.

"InMemoryLogger new runDuring: [ GLMCompositePresentation new
    with: [ :c |
        c fastList selectionAct: #inspect entitled: ''Value'' ];
    openOn: (1 to: 42) ]"').
	GTSnippets reset.
	GTSnippets snippetAt: OrderedCollection put: '| view |
view := RTMondrian new.
view shape label text: [:each | each gtDisplayString truncate: 50 ] .
view nodes: (self first, self second) asSet.
self first
    overlappingPairsDo: [ :a :b |
        view edges
            connectFrom: [:x | b ]
            to: [:x | a ] ].
self second
    overlappingPairsDo: [ :a :b |
        view edges
            connectFrom: [:x | b ]
            to: [:x | a ] ].
view layout tree.
view.'.
	GTSnippets snippetAt: InMemoryLogger put: 'self recordings collect: #stack'
]
