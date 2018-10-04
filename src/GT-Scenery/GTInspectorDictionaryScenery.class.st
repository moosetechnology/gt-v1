Class {
	#name : #GTInspectorDictionaryScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorDictionaryScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 1.0; 
		parent: #GTScenery;
		label: 'Inspector - Dictionary Basic';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorDictionaryScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: '{
	#number -> 42 . 
	#string -> ''fourty-two'' . 
	#date -> Date today } 
		asDictionary')
]
