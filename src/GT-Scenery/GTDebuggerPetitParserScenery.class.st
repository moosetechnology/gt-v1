Class {
	#name : #GTDebuggerPetitParserScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTDebuggerPetitParserScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 201.0; 
		parent: #GTScenery;
		label: 'Debugger - PetitParser';
		action:[self new setUp];
		withSeparatorAfter
]

{ #category : #setUp }
GTDebuggerPetitParserScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: 'PPArithmeticParser parse: ''1+(2/3+4*5)''')
]
