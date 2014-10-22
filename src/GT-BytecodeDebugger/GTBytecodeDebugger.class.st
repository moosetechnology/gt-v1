Class {
	#name : #GTBytecodeDebugger,
	#superclass : #GTGenericStackDebugger,
	#instVars : [
		'symbolicBytecodes'
	],
	#category : #'GT-BytecodeDebugger'
}

{ #category : #accessing }
GTBytecodeDebugger class >> defaultTitle [

	^ 'Bytecode Debugger'
]

{ #category : #'tools registry' }
GTBytecodeDebugger class >> register [

	self registerToolsOn: Smalltalk tools.
]

{ #category : #'tools registry' }
GTBytecodeDebugger class >> registerToolsOn: registry [

	"Add ourselves to registry. See [Smalltalk tools]" 
	registry registerDebugger: self withRank: 10.
]

{ #category : #'as yet unclassified' }
GTBytecodeDebugger >> methodCodeIn: composite forContext: aContext [

	(self methodCodeWidgetIn: composite forContext: aContext)
		initialize: [ :code | |pc|
			symbolicBytecodes := self currentContext method symbolicBytecodes.
				pc := self currentContext pc.
				code selection: (symbolicBytecodes detect: [ :each | each offset = pc] ifNone: [ nil ] ).
			"code selectionInterval: (self session selectedCodeRangeForContext: self currentContext)" ];
		with: [ :code | "self installCodeActionsFor: code "]
]

{ #category : #'as yet unclassified' }
GTBytecodeDebugger >> methodCodeWidgetIn: composite forContext: aContext [

	^ composite tree
		title: 'Bytecode';
		rootsExpanded;
		display: [ symbolicBytecodes ];
		children: [ :each | each isArray ifTrue: [each] ifFalse: #() ];
		format: [ :each | each printString].
]
