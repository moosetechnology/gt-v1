Extension { #name : #GLMCompositePresentation }

{ #category : #'*GT-GlamourDebugger' }
GLMCompositePresentation >> umlClassWithTitle: umlName view: view nodes: aNodes forEach: aOneArgForEachBlock [

	self 
		umlClassWithTitle: umlName 
		view: view 
		nodes: aNodes 
		forEachInstanceVariable: [:e | e]
		methods: aOneArgForEachBlock
]

{ #category : #'*GT-GlamourDebugger' }
GLMCompositePresentation >> umlClassWithTitle: umlName view: view nodes: aNodes 
forEachInstanceVariable: aOneArgForEachBlock1 methods: aOneArgForEachBlock2 [

	view shape rectangle color: Color white.
	view extensibleSizeWithPaddingGap: 0. 
	view nodes: aNodes forEach: [ :eachNode |
		view interaction 
				nodraggable;
				forward: ROAbstractMouseDragging;
				forward: ROMouseClick.
		view interaction popupText.
		view shape centeredLabel text: umlName.
		view node: eachNode.

		view interaction 
				nodraggable;
				forward: ROAbstractMouseDragging;
				forward: ROMouseClick.
		view shape rectangle.
		view nodes: (Array with: eachNode) forEach: aOneArgForEachBlock1.

		view interaction 
				nodraggable;
				forward: ROAbstractMouseDragging;
				forward: ROMouseClick.
		view shape rectangle color: Color white.
		view nodes: (Array with: eachNode) forEach: aOneArgForEachBlock2.
		
		view verticalLineLayout
				gapSize: 0;
				on: ROLayoutBegin
				do: [ :event | | maxWidth |
						maxWidth := event elements maxValue: #width. 
						event elements do: [ :eachElement | 
								eachElement width: maxWidth ] ];
				on: ROLayoutEnd
				do: [ :event | | strategy |
						strategy := ROFixedSizedParent new paddingGap: 0.
						event elements do: [ :eachElement |
								eachElement resizeStrategy: strategy ] ]
	].
]

{ #category : #'*GT-GlamourDebugger' }
GLMCompositePresentation >> viewTreeOn: view [
	| edges1 edges2 edges3 edges4 |
	
	self umlClassWithTitle: #name view: view nodes: self pane withAllPanes forEach: [ :each |
		view interaction
				nodraggable;
				forward: ROAbstractMouseDragging.
		view shape label text: #name.
		view nodes: each ports.
		view verticalLineLayout gapSize: 2 ].

	view shape label text: [:p | (p class name removePrefix: 'GLM') removeSuffix: 'Presentation' ].
	view nodes: self pane withAllPresentations.

	view shape orthoVerticalLine color: Color lightGray. 	
	edges1 := view edges: self pane withAllPanes from: #yourself to: [:each | each presentations ].

	view shape orthoVerticalLine color: Color lightGray. 
	edges2 := view edges: self pane withAllPanes from: #browser to: #yourself.

	view shape orthoVerticalLine color: Color lightGray. 
	edges3 := view edges: (self pane withAllPresentations select: [:each | each isKindOf: GLMDynamicPresentation]) from: #yourself to: #cachedPresentation.

	view shape orthoVerticalLine color: Color lightGray.
	edges4 := view edges: (self pane withAllPresentations select: [:each | each isKindOf: GLMCompositePresentation]) from: #yourself toAll: #presentations.


	view treeLayout layered userDefinedEdges: (edges1, edges2, edges3, edges4).

	view shape line color: Color blue. 
	view 
		edges: ((self pane withAllPresentations select: [:each | each isKindOf: GLMBrowser]) flatCollect: [:each | each transmissions])
		fromAll: #origins
		to: #destination.
		view shape line color: Color blue

]
