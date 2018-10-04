Class {
	#name : #GTInspectorFullDictionaryScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTInspectorFullDictionaryScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 1.2; 
		parent: #GTScenery;
		label: 'Inspector - Dictionary Full';
		action:[self new setUp]
]

{ #category : #setUp }
GTInspectorFullDictionaryScenery >> setUpFull [
	self cleanWindows.
	(GTPlayground openContents: 'OrderPreservingDictionary new
	at: #Morph put: HSVAColorSelectorMorph new; 
	at: #FileReference_dir put: ''data'' asFileReference;
	at: #Time put: Time now;
	at: #Date put: Date today;
	at: #ByteArray put: #[2r1010 8r333 16rFF];
	at: #OrderedCollection put: (1 to: 100) asOrderedCollection;
	at: #Color put: Color lightGreen;
	at: #RTView put: RTMapExample new exampleSouthAmericaPopulation;
	at: #Class put: RTGrapher;
	at: #Slot put: (Morph slotNamed: #bounds);
	at: #CompiledMethod put: Object>>#printString;	
	at: #GLMBrowser put: (MooseMetaBrowser new buildBrowser; browser);
	at: #PPParser put: PPArithmeticParser new;
	at: #MessageTally put: MessageTally gtExampleSimplePrintString;
	at: #MetacelloVersion put: (ConfigurationOfGTInspector project version: #development);
	at: #GTInspector put: GTInspector;
	yourself.')
]
