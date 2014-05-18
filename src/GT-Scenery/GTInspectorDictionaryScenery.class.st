Class {
	#name : #GTInspectorDictionaryScenery,
	#superclass : #Scenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorDictionaryScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 1.0; 
		parent: #Scenery;
		label: 'Inspector - Dictionary';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorDictionaryScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: '{
	#number -> 42 . 
	#string -> ''fourty-two'' . 
	#date -> Date today } 
		asDictionary') maximize
]
