Class {
	#name : #GTInspectorCompiledMethodScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorCompiledMethodScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 20.0; 
		parent: #GTScenery;
		label: 'Inspector - CompiledMethod';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorCompiledMethodScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: 'Object>>#deep:do:') maximize
]
