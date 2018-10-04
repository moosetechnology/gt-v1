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
		label: 'Inspector - Dictionary Extended';
		action:[self new setUp]
]

{ #category : #initialization }
GTInspectorComplexDictionaryScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: 'OrderedDictionary  new
	at: ''Time''                put: Time now;
	at: ''Morph''              put: HSVAColorSelectorMorph new; 
	at: ''FileReference''  put: ''data'' asFileReference;
	at: ''Date''                put: Date today;
	at: ''Color''               put: Color cyan;
	at: ''GTInspector''    put: GTInspector;
	yourself.')
]
