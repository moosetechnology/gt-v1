Extension { #name : #GeneralScrollPane }

{ #category : #'*GT-InspectorExtensions-Core' }
GeneralScrollPane class >> gtScrollerWithWrappingAndNoSpaceFilling [
	"
	self gtScrollerWithWrappingAndNoSpaceFilling openInWindow
	"

	<example>
	| scrollpane pane |
	scrollpane := GeneralScrollPane new.
	scrollpane changeScrollerTableLayout.
	pane := PanelMorph new
		changeTableLayout;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself.
	scrollpane scrollTarget: pane.
	Object methods
		do: [ :each | 
			| methodLabel |
			methodLabel := each selector asTextMorph lock 
				backgroundColor: Color lightBlue.
				
			pane addMorph: methodLabel ].
	scrollpane
		hResizing: #shrinkWrap;
		height: 400.
	^ scrollpane
]

{ #category : #'*GT-InspectorExtensions-Core' }
GeneralScrollPane class >> gtScrollerWithWrappingAndSpaceFilling [
	"
	self gtScrollerWithWrappingAndSpaceFilling openInWindow
	"

	<example>
	| scrollpane pane |
	scrollpane := GeneralScrollPane new.
	scrollpane changeScrollerTableLayout.
	pane := PanelMorph new
		changeTableLayout;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself.
	scrollpane scrollTarget: pane.
	Object methods
		do: [ :each | 
			| methodLabel |
			methodLabel := Morph new
				changeTableLayout;
				wrapCentering: #center;
				hResizing: #spaceFill;
				vResizing: #spaceFill;
				color: Color lightBlue.
			methodLabel addMorphBack: (each selector asTextMorph lock).
				
			pane addMorph: methodLabel ].
	scrollpane
		hResizing: #shrinkWrap;
		height: 400.
	^ scrollpane
]
