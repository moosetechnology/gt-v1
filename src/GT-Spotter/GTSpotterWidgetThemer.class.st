"
This is a themer for all spotter morphs.

To customize it, it has to be subclassed and pointed to from:
ACustomTheme>>spotterWidgetThemer
"
Class {
	#name : #GTSpotterWidgetThemer,
	#superclass : #Object,
	#category : #'GT-Spotter-Theme'
}

{ #category : #values }
GTSpotterWidgetThemer >> backgroundColor [
	"used as background color for all panes"
	^ Color white
]

{ #category : #values }
GTSpotterWidgetThemer >> borderColor [
	"color that is used for border and dividers of UI parts of Spotter
	for example divider between header and results or between preview and list"
	^ Color r: 180 g: 180 b: 180 range: 255
]

{ #category : #styles }
GTSpotterWidgetThemer >> breadcrumbItemStyleFor: aBrick [

	aBrick
		textPosition: #center;
		normalColor: self borderColor;
		textColor: Color white.
	
	aBrick layoutProperties
		marginTop: self outerBorderWidth;
		marginRight: self outerBorderWidth;
		paddingLeft: self outerBorderWidth;
		paddingRight: self outerBorderWidth
]

{ #category : #styles }
GTSpotterWidgetThemer >> breadcrumbStyleFor: aBrick [
	
	aBrick layoutProperties
		marginLeft: self outerBorderWidth;
		marginRight: self outerBorderWidth
]

{ #category : #values }
GTSpotterWidgetThemer >> buttonPressedColor [

	^ self backgroundColor darker
]

{ #category : #styles }
GTSpotterWidgetThemer >> categoryAmountStyleFor: aBrick [

	aBrick
		textPosition: #leftCenter;
		textColor: self titleTextColor;
		color: self titleBackgroundColor.
	
	aBrick label
		fontSize: self titleFontSize;
		familyName: self titleFamilyName.
	
	aBrick layoutProperties
		hSpaceFill;
		marginLeft: self categoryNameMarginRight.
]

{ #category : #values }
GTSpotterWidgetThemer >> categoryMarginBottom [

	^ (self itemHeight * (2/3)) ceiling "pixels"
]

{ #category : #values }
GTSpotterWidgetThemer >> categoryNameMarginLeft [

	^ self itemIconMaxWidth
]

{ #category : #values }
GTSpotterWidgetThemer >> categoryNameMarginRight [

	^ 10
]

{ #category : #styles }
GTSpotterWidgetThemer >> categoryStyleFor: aBrick [

	aBrick layoutProperties
		marginBottom: self categoryMarginBottom
]

{ #category : #styles }
GTSpotterWidgetThemer >> categoryTitleNameStyleFor: aBrick [

	aBrick
		textPosition: #leftCenter;
		textColor: self titleTextColor;
		color: self titleBackgroundColor.
	
	aBrick label
		fontSize: self titleFontSize;
		familyName: self titleFamilyName.
	
	aBrick layoutProperties
		staticWidth: [ :name | (aBrick owner brickInnerBounds width) min: ((name label textSize x) + name label layoutProperties horizontalMargin) ].
]

{ #category : #styles }
GTSpotterWidgetThemer >> categoryTitleStyleFor: aBrick [

	aBrick
		layoutPolicy: GLMBrickHorizontalFillProportionalLinearLayout new;
		normalColor: (Color white alpha: 0.95);
		selectedColor: (Color veryVeryLightGray lighter alpha: 0.95);
		height: [ 30 ].
	
	aBrick layoutProperties
		floating: #stack;
		paddingLeft: self categoryNameMarginLeft;
		maxWidthBlock: [ :title |
			aBrick layoutProperties horizontalPadding + 
			(title nameBrick label textSize x )+ title amountBrick label textSize x +
			title nameBrick layoutProperties horizontalPadding + title nameBrick layoutProperties horizontalMargin + 
			title nameBrick label layoutProperties horizontalPadding + title nameBrick label layoutProperties horizontalMargin + 
			title amountBrick layoutProperties horizontalMargin ].
]

{ #category : #styles }
GTSpotterWidgetThemer >> closeButtonStyleFor: aBrick [

	aBrick
		normalImage: GLMUIThemeExtraIcons glamorousClose;
		pressedColor: self buttonPressedColor
]

{ #category : #styles }
GTSpotterWidgetThemer >> dropDownPaneStyleFor: aBrick [

	aBrick
		layoutProperties: GLMBrickLayoutProperties new;
		color: self backgroundColor;
		height: 400.

	aBrick layoutProperties
		vSpaceFill;
		marginTop: self innerBorderWidth.
]

{ #category : #values }
GTSpotterWidgetThemer >> headerHeight [
	"height of the header where user enters search request"
	^ 56
]

{ #category : #styles }
GTSpotterWidgetThemer >> headerStyleFor: aBrick [

	aBrick
		height: [ self headerHeight ];
		color: self backgroundColor
]

{ #category : #icons }
GTSpotterWidgetThemer >> iconAct [
	|icon|
	
	icon:= GLMBrickVectorIcons play.
	icon color: (Color gray alpha: 0.8).
	icon layoutProperties paddingLeft: 3.
	icon layoutProperties paddingRight: 3.
	
	^ icon
]

{ #category : #icons }
GTSpotterWidgetThemer >> iconDiveIn [
	|icon|
	
	icon:= GLMBrickVectorIcons right.
	icon color: (Color gray alpha: 0.8).
	
	^ icon
]

{ #category : #values }
GTSpotterWidgetThemer >> innerBorderWidth [
	"width of the border that separates panes in the spotter"
	^ 1
]

{ #category : #styles }
GTSpotterWidgetThemer >> itemActionButtonStyleFor: aBrick [

	aBrick
		width: [ 16 + aBrick layoutProperties horizontalPadding ];
		pressedColor: self itemSelectedBackgroundColor darker.
	
	aBrick layoutProperties
		marginTop: 4;
		marginBottom: 4;
		paddingTop: self outerBorderWidth;
		paddingBottom: self outerBorderWidth;
		paddingLeft: self outerBorderWidth;
		paddingRight: self outerBorderWidth
]

{ #category : #styles }
GTSpotterWidgetThemer >> itemActionbarInvisibleStyleFor: aBrick [

	aBrick layoutProperties staticWidth: 0.
]

{ #category : #styles }
GTSpotterWidgetThemer >> itemActionbarStyleFor: aBrick [

	aBrick layoutPolicy: GLMBrickHorizontalFillLinearLayout new.
	
	aBrick layoutProperties
		marginRight: self outerBorderWidth.
	
	self itemActionbarInvisibleStyleFor: aBrick.
]

{ #category : #styles }
GTSpotterWidgetThemer >> itemActionbarVisibleStyleFor: aBrick [

	aBrick layoutProperties
		staticWidth: [ :actionbar | actionbar subbricks inject: (actionbar layoutProperties horizontalPadding + actionbar layoutProperties horizontalMargin) into: [ :width :each | width + each brickOuterBounds width ] ].
]

{ #category : #values }
GTSpotterWidgetThemer >> itemFamilyName [

	^ 'Open Sans'
]

{ #category : #values }
GTSpotterWidgetThemer >> itemFontSize [

	^ 9
]

{ #category : #values }
GTSpotterWidgetThemer >> itemHeight [

	^ 30
]

{ #category : #values }
GTSpotterWidgetThemer >> itemHoveredBackgroundColor [

	^ Color transparent
]

{ #category : #styles }
GTSpotterWidgetThemer >> itemHoveredStyleFor: aBrick [

	aBrick color: self itemHoveredBackgroundColor
]

{ #category : #values }
GTSpotterWidgetThemer >> itemIconAlphaValue [

	^ 0.8
]

{ #category : #values }
GTSpotterWidgetThemer >> itemIconMaxWidth [

	^ 50
]

{ #category : #styles }
GTSpotterWidgetThemer >> itemIconStyleFor: aBrick [
	"icon form must already be set before styling"
	
	"making icon a bit transparent"
	aBrick normalImage: (aBrick normalImage asAlphaImageMorph alpha: self itemIconAlphaValue) cachedForm.
	
	aBrick layoutProperties
		marginLeft: self titleMarginLeft;
		"margin right depends on maximal icon width and on image form width"
		marginRight: (self itemIconMaxWidth - aBrick normalImage width - aBrick layoutProperties marginLeft);
		staticWidth: (aBrick normalImage width + aBrick layoutProperties horizontalMargin).
]

{ #category : #styles }
GTSpotterWidgetThemer >> itemLabelStyleFor: aBrick [

	aBrick label
		familyName: self itemFamilyName;
		fontSize: self itemFontSize;
		highlightingLogic: [ :aCanvas :aRectangle | | linePath stroke|
			linePath := aCanvas createPath: [:builder |
				builder
					absolute;
					moveTo: aRectangle bottomLeft;
     				lineTo: aRectangle bottomRight - (3@0) ].
			stroke := aCanvas setStrokePaint: Color lightGray.
			stroke width: 1.
			aCanvas drawShape: linePath ].
		
	aBrick layoutProperties
		hSpaceFill;
		marginRight: self outerBorderWidth.
]

{ #category : #values }
GTSpotterWidgetThemer >> itemNormalBackgroundColor [

	^ Color transparent
]

{ #category : #styles }
GTSpotterWidgetThemer >> itemNormalStyleFor: aBrick [

	aBrick
		normalColor: self itemNormalBackgroundColor;
		selectedColor: self itemHoveredBackgroundColor;
		checkedColor: self itemSelectedBackgroundColor;
		height: [ self itemHeight ]
]

{ #category : #values }
GTSpotterWidgetThemer >> itemSelectedBackgroundColor [

	^ self backgroundColor darker
]

{ #category : #styles }
GTSpotterWidgetThemer >> itemSelectedStyleFor: aBrick [

	aBrick color: self itemSelectedBackgroundColor
]

{ #category : #values }
GTSpotterWidgetThemer >> outerBorderWidth [
	"the width of the border around the whole spotter"
	^ 5
]

{ #category : #styles }
GTSpotterWidgetThemer >> resultsPaneStyleFor: aBrick [

	aBrick band layoutPolicy: GLMBrickVerticalLinedStackLayout new.
	aBrick layoutProperties horizontalPercent: self resultsPaneWidth.
	aBrick color: self backgroundColor.
	aBrick verticalScrollbar bar color: self resultsScrollbarColor.
	aBrick verticalScrollbar width: self resultsScrollbarWidth.
	aBrick verticalScrollbar layoutProperties marginRight: self resultsScrollbarMarginRight.
]

{ #category : #values }
GTSpotterWidgetThemer >> resultsPaneWidth [
	"width in Percents of the results pane"
	^ 100"%"
]

{ #category : #'values scrollbar' }
GTSpotterWidgetThemer >> resultsScrollbarColor [
	^ Color lightGray alpha: 0.2
]

{ #category : #'values scrollbar' }
GTSpotterWidgetThemer >> resultsScrollbarMarginRight [
	^ 1
]

{ #category : #'values scrollbar' }
GTSpotterWidgetThemer >> resultsScrollbarWidth [
	^ 3
]

{ #category : #values }
GTSpotterWidgetThemer >> searchFieldFamilyName [

	^ 'Source Sans Pro'
]

{ #category : #values }
GTSpotterWidgetThemer >> searchFieldFontSize [

	^ 15
]

{ #category : #values }
GTSpotterWidgetThemer >> searchFieldMarginLeft [

	^ 20
]

{ #category : #styles }
GTSpotterWidgetThemer >> searchFieldStyleFor: aMorph [

	aMorph
		layoutProperties: GLMBrickLayoutProperties new;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		color: Color transparent;
		withoutAdornment;
		withGhostText: self spotterGhostText;
		autoAccept: true;
		borderColor: Color white.
		
	aMorph layoutProperties
		hSpaceFill;
		marginLeft: self searchFieldMarginLeft.
	
	aMorph ghostTextRuler
		fontName: self searchFieldFamilyName pointSize: self searchFieldFontSize.
		
	aMorph textArea
		font: (LogicalFont familyName: self searchFieldFamilyName pointSize: self searchFieldFontSize);
		backgroundColor: Color transparent.
]

{ #category : #styles }
GTSpotterWidgetThemer >> spotterContentsStyleFor: aBrick [

	aBrick
		borderColor: self borderColor;
		borderWidth: self outerBorderWidth;
		color: self borderColor.
	
	aBrick layoutProperties
		paddingTop: self outerBorderWidth;
		paddingBottom: self outerBorderWidth;
		paddingLeft: self outerBorderWidth;
		paddingRight: self outerBorderWidth
	
]

{ #category : #values }
GTSpotterWidgetThemer >> spotterGhostText [

	^ 'Spotter search'
]

{ #category : #styles }
GTSpotterWidgetThemer >> spotterStyleFor: aBrick [

	aBrick brickRoot: GLMBandBrick new.
]

{ #category : #styles }
GTSpotterWidgetThemer >> stepPaneStyleFor: aBrick [

	aBrick color: self borderColor
]

{ #category : #styles }
GTSpotterWidgetThemer >> stepsBandStyleFor: aBrick [

	aBrick
		layoutPolicy: GLMBrickHorizontalFillProportionalLinearLayout new;
		width: [ 0 ]
]

{ #category : #values }
GTSpotterWidgetThemer >> titleBackgroundColor [

	^ Color transparent
]

{ #category : #values }
GTSpotterWidgetThemer >> titleFamilyName [
	^ 'Open Sans'.
]

{ #category : #values }
GTSpotterWidgetThemer >> titleFontSize [

	^ 9
]

{ #category : #values }
GTSpotterWidgetThemer >> titleMarginLeft [
	^ 20
]

{ #category : #values }
GTSpotterWidgetThemer >> titleTextColor [

	^ self titleBackgroundColor muchDarker
]
