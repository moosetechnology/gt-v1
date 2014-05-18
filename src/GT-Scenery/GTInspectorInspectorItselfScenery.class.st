Class {
	#name : #GTInspectorInspectorItselfScenery,
	#superclass : #Scenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorInspectorItselfScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 5.0; 
		parent: #Scenery;
		label: 'Inspector - Inspector';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorInspectorItselfScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: 'GTInspector') maximize
]
