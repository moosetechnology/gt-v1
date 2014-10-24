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
