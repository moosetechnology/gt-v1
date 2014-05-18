Class {
	#name : #GTInspectorInspectorSizeScenery,
	#superclass : #Scenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorInspectorSizeScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 10.0; 
		parent: #Scenery;
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
