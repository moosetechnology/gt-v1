"
This is a simple browser that displays the rb tree and previews each node on the source code.

Example:
self openOn: (self>>#buildBrowser) parseTree
"
Class {
	#name : #GTSimpleParseTreeBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'GT-Inspector'
}

{ #category : #building }
GTSimpleParseTreeBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Tree'.
	browser
		row: #tree;
		row: #source.
	browser transmit
		to: #tree;
		andShow: [ :a | self treeIn: a ].
	browser transmit
		to: #source;
		andShow: [ :a | self sourceIn: a ].
	browser transmit
		from: #tree;
		to: #source port: #selectionInterval;
		transformed: [ :rbNode | rbNode sourceInterval ].
	browser transmit
		toOutsidePort: #selection;
		from: #tree port: #selectedNode.
	^ browser
]

{ #category : #building }
GTSimpleParseTreeBrowser >> sourceIn: a [
	^ a text display: [ :each | each source ]
]

{ #category : #building }
GTSimpleParseTreeBrowser >> treeIn: a [
	^ a tree
		rootsExpanded;
		display: [ :anObject | {anObject} ];
		children: [ :each | each children ];
		selectionPopulate: #selectedNode
			on: $o
			entitled: 'Open'
			with: [ :tree | tree selection ];
		format: [ :each | 
					String
						streamContents: [ :stream | 
							stream
								nextPutAll: each class name;
								nextPut: $(;
								nextPutAll: ((each formattedCode truncateTo: 50) copyReplaceAll: String cr with: String space);
								nextPut: $) ] ]
]
