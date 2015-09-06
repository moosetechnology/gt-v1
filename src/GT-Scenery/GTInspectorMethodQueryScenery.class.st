Class {
	#name : #GTInspectorMethodQueryScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorMethodQueryScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 21.0; 
		parent: #GTScenery;
		label: 'Inspector - Method Query';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorMethodQueryScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: '(Object 
	withDeep: #subclasses 
	flatCollect: [ :each |
		Pragma
			allNamed: #gtInspectorPresentationOrder:
			in: each ])
	collect: [:each | each method asRingDefinition]')
]
