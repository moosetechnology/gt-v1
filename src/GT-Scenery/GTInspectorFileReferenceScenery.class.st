Class {
	#name : #GTInspectorFileReferenceScenery,
	#superclass : #Scenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorFileReferenceScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 4.0; 
		parent: #Scenery;
		label: 'Inspector - FileReference';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorFileReferenceScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: 'FileSystem disk workingDirectory') maximize.
	GTSnippets reset
]
