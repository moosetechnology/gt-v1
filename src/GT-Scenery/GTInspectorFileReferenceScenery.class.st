Class {
	#name : #GTInspectorFileReferenceScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorFileReferenceScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 5.0; 
		parent: #GTScenery;
		label: 'Inspector - FileReference';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorFileReferenceScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: 'FileSystem workingDirectory').
	GTSnippets reset
]
