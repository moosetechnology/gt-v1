Class {
	#name : #GTInspectorMessageTallyScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorMessageTallyScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 21.0; 
		parent: #GTScenery;
		label: 'Inspector - MessageTally';
		action: [ self new setUp ]
]

{ #category : #setUp }
GTInspectorMessageTallyScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: 'MessageTally on: [ XMLParserTest new benchmark3 ].')
]
