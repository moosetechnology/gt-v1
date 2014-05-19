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
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorInspectorSizeScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: '(RPackageOrganizer default packageNamed: #''GT-Inspector'') linesOfCode + 
((RPackageOrganizer default packages 
	select: [:each | each name beginsWith: ''GT-InspectorExtensions'']) 
		sum: #linesOfCode)') maximize
]
