Class {
	#name : #GTInspectorColorScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorColorScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 2.0; 
		parent: #GTScenery;
		label: 'Inspector - Color';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorColorScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: 'Color indexedColors atRandom')
]
