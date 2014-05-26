Class {
	#name : #GTInspectorInspectorItselfScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorInspectorItselfScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 101.0; 
		parent: #GTScenery;
		label: 'Inspector - Inspector';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorInspectorItselfScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: 'GTInspector') maximize
]
