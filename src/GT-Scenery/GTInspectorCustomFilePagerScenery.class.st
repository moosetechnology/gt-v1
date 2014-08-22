Class {
	#name : #GTInspectorCustomFilePagerScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorCustomFilePagerScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 310.0; 
		parent: #GTScenery;
		label: 'Playground - Custom File Pager';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorCustomFilePagerScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: 'GLMPager new 
	with: [ :pager |
		pager show: [ :a :file |
			file gtInspectorItemsIn: a.
			file gtInspectorPngIn: a.
			file gtInspectorStScriptIn: a.
			file gtInspectorContentsIn: a ]];
     openOn: FileSystem disk workingDirectory').

]
