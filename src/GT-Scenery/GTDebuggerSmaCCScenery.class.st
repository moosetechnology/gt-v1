Class {
	#name : #GTDebuggerSmaCCScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTDebuggerSmaCCScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 200.0; 
		parent: #GTScenery;
		label: 'Debugger - SmaCC';
		action:[self new setUp]
]

{ #category : #setUp }
GTDebuggerSmaCCScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: 'JSParser parse: ''1+2
3*4
5/6
7^8''')
]
