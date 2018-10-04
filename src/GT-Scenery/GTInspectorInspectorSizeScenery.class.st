Class {
	#name : #GTInspectorInspectorSizeScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorInspectorSizeScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 100.0; 
		parent: #GTScenery;
		label: 'Inspector - Inspector size';
		action:[self new setUp];
		withSeparatorAfter
]

{ #category : #setUp }
GTInspectorInspectorSizeScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: 'GTInspector package linesOfCode + 
(GTInspector inspectorExtendingMethods sum: #numberOfLinesOfCode).')
]
