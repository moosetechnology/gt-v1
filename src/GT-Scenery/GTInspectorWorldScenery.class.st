Class {
	#name : #GTInspectorWorldScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorWorldScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 4.0; 
		parent: #GTScenery;
		label: 'Inspector - World';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorWorldScenery >> setUp [
	self cleanWindows.
	SettingBrowser open extent: 600@400.
	GTPlayground openContents: '1 / 0.
World'
]
