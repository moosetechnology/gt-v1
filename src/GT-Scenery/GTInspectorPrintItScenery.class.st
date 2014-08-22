Class {
	#name : #GTInspectorPrintItScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorPrintItScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 300.0; 
		parent: #GTScenery;
		label: 'Playground - Print It with Delay';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorPrintItScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: '"One has to wait a little to gets
the perfect answer"
(Delay forMilliseconds: 1000) wait.
42').
	(Workspace openContents: '"One has to wait a little to gets
the perfect answer"
(Delay forMilliseconds: 1000) wait.
42' label: 'Workspace')
]
