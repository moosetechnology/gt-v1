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
	| b label line elements |

	b := RTUMLClassBuilder new.
	b
		addObjects: self pane withAllPanes;
		classname: #name;
		instanceVariables: nil;
		methodsNames: #ports;
		methodselector: #name;
		attributeselector: nil;
		buildSchema: view.
	elements := RTGroup new.
	elements addAll: b classesGroup.
	
	label := RTLabel new height: 10; text: [:p | (p class name removePrefix: 'GLM') removeSuffix: 'Presentation' ].
	
	self pane withAllPresentations do: [ :p | | e |
		view add: (e:= (label elementOn: p ) @ RTDraggable).
		elements add: e ].
	
	line := RTMultiLine new orthoVertical attachPoint: RTVerticalAttachPoint instance.
	
	RTEdge buildEdgesFromObjects: self pane withAllPanes 
		from: #yourself to: [ :each | each presentations ] using: line inView: view.
	
	RTEdge buildEdgesFromObjects: self pane withAllPanes 
		from: #browser to: #yourself using: line inView: view.
		
	RTEdge buildEdgesFromObjects: (self pane withAllPresentations select: [:each | each isKindOf: GLMDynamicPresentation])
		from: #yourself to: #cachedPresentation using: line inView: view scope: elements.
		
	RTEdge buildEdgesFromObjects: (self pane withAllPresentations select: [:each | each isKindOf: GLMCompositePresentation])
		from: #yourself toAll: #presentations using: line inView: view scope: elements.
		
	RTTreeLayout new on: elements.
	
	line := RTLine new color: Color blue; attachPoint: RTShorterDistanceAttachPoint instance.
	RTEdge buildEdgesFromObjects: ((self pane withAllPresentations select: [:each | each isKindOf: GLMBrowser]) flatCollect: [:each | each transmissions])
		from: #destination toAll: #origins using: line inView: view.
	
]
