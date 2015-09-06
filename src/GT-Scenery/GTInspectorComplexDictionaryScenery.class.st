Class {
	#name : #GTInspectorComplexDictionaryScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorComplexDictionaryScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 1.1; 
		parent: #GTScenery;
		label: 'Inspector - Dictionary 2';
		action:[self new setUp]
]

{ #category : #'as yet unclassified' }
GTInspectorComplexDictionaryScenery >> setUp [
	"self cleanWindows."
	(GTPlayground openContents: 'Dictionary new
   	at: #date put: Date today;
   at: #text put: Text loremImpsum;
	at: #color put: Color red;
	yourself.')
]
