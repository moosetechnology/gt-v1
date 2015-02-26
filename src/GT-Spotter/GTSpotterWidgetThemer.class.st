"
This is a themer for all spotter morphs.

To customize it, it has to be subclassed and pointed to from:
ACustomTheme>>spotterWidgetThemer
"
Class {
	#name : #GTSpotterWidgetThemer,
	#superclass : #GLMBrickThemerModule,
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

{ #category : #values }
GTSpotterWidgetThemer >> breadcrumbHeight [

	^ 26
]

{ #category : #values }
GTSpotterWidgetThemer >> breadcrumbItemBackgroundColor [

	^ self borderColor
]

{ #category : #styles }
GTSpotterWidgetThemer >> breadcrumbItemLabelStyleFor: aBrick [

	aBrick
		textPosition: #center;
		color: self breadcrumbItemBackgroundColor;
		textColor: self breadcrumbItemTextColor;
		padding: { 0 . self outerBorderWidth };
		vSpaceFill;
		hSpaceFill
]

{ #category : #styles }
GTSpotterWidgetThemer >> breadcrumbItemStyleFor: aBrick [

	aBrick vSpaceFill
]

{ #category : #values }
GTSpotterWidgetThemer >> breadcrumbItemTextColor [

	^ Color white
]

{ #category : #styles }
GTSpotterWidgetThemer >> breadcrumbItemTriangleStyleFor: aBrick [

	aBrick
		renderer: (GTSpotterTriangleRenderer new orientation: #bottom);
		height: self breadcrumbTriangleHeight;
		color: self breadcrumbItemBackgroundColor;
		hSpaceFill
]

{ #category : #values }
GTSpotterWidgetThemer >> breadcrumbSeparatorColor [

	^ self breadcrumbItemBackgroundColor muchLighter slightlyDarker
]

{ #category : #values }
GTSpotterWidgetThemer >> breadcrumbSeparatorLineWidth [

	^ 2
]

{ #category : #styles }
GTSpotterWidgetThemer >> breadcrumbSeparatorStyleFor: aBrick [

	aBrick
		color: self breadcrumbItemBackgroundColor;
		borderWidth: self breadcrumbSeparatorLineWidth;
		borderColor: self breadcrumbSeparatorColor;
		renderer: GTSpotterBreadcrumbSeparatorRenderer new;
		width: self breadcrumbSeparatorWidth;
		height: self breadcrumbHeight + self outerBorderWidth.
]

{ #category : #values }
GTSpotterWidgetThemer >> breadcrumbSeparatorWidth [

	^ (self breadcrumbHeight + self outerBorderWidth) / 2 + 4 "we need slightly more because of drawing accuracy"
]

{ #category : #styles }
GTSpotterWidgetThemer >> breadcrumbStyleFor: aBrick [
	
	aBrick
		margin: { 0 . 0 };
		marginBottom: self breadcrumbTriangleHeight negated;
		height: self breadcrumbHeight + self breadcrumbTriangleHeight.
		
	aBrick layout
		zIndex: 2.
]

{ #category : #values }
GTSpotterWidgetThemer >> breadcrumbTriangleHeight [

	^ 16
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
	
	aBrick
		vSpaceFill;
		width: #approximateWidth;
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

	aBrick
		marginBottom: self categoryMarginBottom;
		hSpaceFill
]

{ #category : #values }
GTSpotterWidgetThemer >> categoryTitleBackgroundColor [

	^ Color white alpha: 0.95
]

{ #category : #styles }
GTSpotterWidgetThemer >> categoryTitleNameStyleFor: aBrick [

	aBrick
		vSpaceFill;
		textPosition: #leftCenter;
		textColor: self titleTextColor;
		width: [ :name | (aBrick owner innerBounds width) min: ((name label textSize x) + name label hMargin) ];
		color: self titleBackgroundColor.
	
	aBrick label
		fontSize: self titleFontSize;
		familyName: self titleFamilyName.
	
]

{ #category : #styles }
GTSpotterWidgetThemer >> categoryTitleStyleFor: aBrick [

	aBrick
		useHorizontalLinearLayout;
		normalColor: self categoryTitleBackgroundColor;
		height: 30;
		hSpaceFill;
		paddingLeft: self categoryNameMarginLeft
	
	"aBrick layout
		floating: #stack;
		maxWidth: [ :title |
			aBrick hPadding + 
			(title nameBrick label textSize x )+ title amountBrick label textSize x +
			title nameBrick hPadding + title nameBrick hMargin + 
			title nameBrick label hPadding + title nameBrick label hMargin + 
			title amountBrick hMargin ]"
]

{ #category : #styles }
GTSpotterWidgetThemer >> closeButtonStyleFor: aBrick [

	aBrick
		vSpaceFill;
		width: [ :m | m height ];
		normalImage: GLMUIThemeExtraIcons glamorousClose;
		pressedColor: self buttonPressedColor
]

{ #category : #styles }
GTSpotterWidgetThemer >> dropDownPaneStyleFor: aBrick [

	aBrick
		layoutProperties: GLMBrickLayoutProperties new;
		color: self backgroundColor;
		marginTop: self innerBorderWidth;
		vSpaceFill;
		hSpaceFill
]

{ #category : #values }
GTSpotterWidgetThemer >> headerHeight [
	"height of the header where user enters search request"
	^ 56
]

{ #category : #styles }
GTSpotterWidgetThemer >> headerStyleFor: aBrick [

	aBrick
		color: self backgroundColor;
		hSpaceFill;
		height: self headerHeight
]

{ #category : #icons }
GTSpotterWidgetThemer >> iconAct [

	^ Smalltalk ui icons glamorousAccept
]

{ #category : #icons }
GTSpotterWidgetThemer >> iconDiveIn [

	^ Smalltalk ui icons glamorousDiveRightIcon
]

{ #category : #icons }
GTSpotterWidgetThemer >> iconDiveInCategory [

	^ Smalltalk ui icons glamorousDiveAllRightIcon
]

{ #category : #values }
GTSpotterWidgetThemer >> innerBorderWidth [
	"width of the border that separates panes in the spotter"
	^ 1
]

{ #category : #styles }
GTSpotterWidgetThemer >> itemActionButtonStyleFor: aBrick [

	aBrick
		width: [ (self itemHeight / 1.1) floor ];
		vSpaceFill;
		pressedColor: self itemActionSelectedBackgroundColor;
		padding: { 0 . self outerBorderWidth }
]

{ #category : #values }
GTSpotterWidgetThemer >> itemActionSelectedBackgroundColor [

	^ self itemSelectedBackgroundColor darker
]

{ #category : #styles }
GTSpotterWidgetThemer >> itemActionbarStyleFor: aBrick [

	aBrick
		useHorizontalLinearLayout;
		hShrinkWrap;
		vSpaceFill;
		marginRight: self outerBorderWidth;
		visible: false
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

	self flag: 'figure out why alpha doesn''t work'.
	aBrick
		"making icon a bit transparent"
		"normalImage: (aBrick normalImage asAlphaImageMorph alpha: self itemIconAlphaValue) imageForm;"
		width: self itemIconMaxWidth;
		vSpaceFill
]

{ #category : #styles }
GTSpotterWidgetThemer >> itemLabelStyleFor: aBrick [

	aBrick label
		familyName: self itemFamilyName;
		fontSize: self itemFontSize;
		textColor: self itemTextColor;
		highlightingLogic: [ :aCanvas :aRectangle | |bounds|
			"because font calculates text width wrong"
			bounds := aRectangle translateBy: (-3@0).
			aCanvas line: bounds bottomLeft to: bounds bottomRight width: 1 color: Color lightGray ].
	
	aBrick
		hSpaceFill;
		vSpaceFill;
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
		height: [ self itemHeight ];
		hSpaceFill
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
GTSpotterWidgetThemer >> itemTextColor [

	^ Color black
]

{ #category : #values }
GTSpotterWidgetThemer >> outerBorderWidth [
	"the width of the border around the whole spotter"
	^ 4
]

{ #category : #values }
GTSpotterWidgetThemer >> previewArrowColor [

	^ self itemSelectedBackgroundColor
]

{ #category : #values }
GTSpotterWidgetThemer >> previewArrowGapHack [

	^ self themer scrollbarOffset + self themer scrollbarWidth + self outerBorderWidth + 1"pager bug"
]

{ #category : #values }
GTSpotterWidgetThemer >> previewArrowWidth [

	^ (self itemHeight / 2) + self previewArrowGapHack
]

{ #category : #values }
GTSpotterWidgetThemer >> previewBorderWidth [

	^ self outerBorderWidth
]

{ #category : #values }
GTSpotterWidgetThemer >> previewPaddingLeft [

	^ self previewArrowWidth * 1.2
]

{ #category : #values }
GTSpotterWidgetThemer >> previewPaddingRight [

	^ self previewPaddingLeft


]

{ #category : #values }
GTSpotterWidgetThemer >> previewWidthPercent [

	^ 40
]

{ #category : #styles }
GTSpotterWidgetThemer >> resultsPaneStyleFor: aBrick [

	aBrick
		hSpaceFill: self resultsPaneWidth;
		vSpaceFill;
		color: self backgroundColor;
		with: [ :b | b band layout: GTSpotterStackedLayout new ]
]

{ #category : #values }
GTSpotterWidgetThemer >> resultsPaneWidth [
	"width in Percents of the results pane"
	^ 100"%"
]

{ #category : #values }
GTSpotterWidgetThemer >> searchFieldCursorColor [

	^ Color black
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
GTSpotterWidgetThemer >> searchFieldStyleFor: aBrick [
	
	aBrick
		hSpaceFill;
		vSpaceFill;
		marginLeft: self searchFieldMarginLeft.
		
	aBrick morph
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		color: Color transparent;
		textColor: self searchFieldTextColor;
		withoutAdornment;
		withGhostText: self spotterGhostText;
		autoAccept: true;
		borderColor: Color transparent;
		borderWidth: 0.
	
	aBrick morph ghostTextRuler
		fontName: self searchFieldFamilyName pointSize: self searchFieldFontSize.
		
	aBrick morph textArea
		font: (LogicalFont familyName: self searchFieldFamilyName pointSize: self searchFieldFontSize);
		backgroundColor: Color transparent
]

{ #category : #values }
GTSpotterWidgetThemer >> searchFieldTextColor [
	
	^ Color black
]

{ #category : #styles }
GTSpotterWidgetThemer >> spotterContentsStyleFor: aBrick [
	
	aBrick
		useVerticalLinearLayout;
		borderColor: self borderColor;
		borderWidth: self outerBorderWidth;
		color: self borderColor;
		padding: self outerBorderWidth;
		hSpaceFill;
		vSpaceFill.
	
	aBrick layout
		zIndex: 2
	
]

{ #category : #values }
GTSpotterWidgetThemer >> spotterGhostText [

	^ 'Spotter search'
]

{ #category : #styles }
GTSpotterWidgetThemer >> spotterPaneStyleFor: aBrick [
	
	aBrick
		useHorizontalLinearLayout;
		hSpaceFill;
		vSpaceFill
]

{ #category : #styles }
GTSpotterWidgetThemer >> spotterPreviewArrowContainerStyleFor: aBrick [

	aBrick
		useVerticalLinearLayout;
		vSpaceFill;
		width: self previewArrowWidth;
		margin: {
			self headerHeight + self innerBorderWidth + self previewBorderWidth.
			0.
			self previewBorderWidth.
			self previewArrowGapHack negated }.
		
	aBrick layout
		zIndex: 4.
]

{ #category : #styles }
GTSpotterWidgetThemer >> spotterPreviewArrowStyleFor: aBrick [

	aBrick
		hSpaceFill;
		renderer: (GTSpotterTriangleRenderer new orientation: #right);
		height: [ (self previewArrowWidth - self previewArrowGapHack ) * 2 ]
]

{ #category : #styles }
GTSpotterWidgetThemer >> spotterPreviewCompositeStyleFor: aBrick [

	aBrick
		hSpaceFill;
		vSpaceFill;
		margin: self previewBorderWidth;
		paddingLeft: self previewPaddingLeft;
		paddingRight: self previewPaddingRight
]

{ #category : #styles }
GTSpotterWidgetThemer >> spotterPreviewStyleFor: aBrick [
	
	aBrick
		borderColor: self borderColor;
		borderWidth: self previewBorderWidth;
		color: self backgroundColor;
		hSpaceFill: self previewWidthPercent;
		vSpaceFill;
		margin: { self headerHeight + self innerBorderWidth. 0 . 0};
		marginLeft: (self previewBorderWidth + self previewArrowWidth) negated.
	
	aBrick layout
		zIndex: 1
]

{ #category : #styles }
GTSpotterWidgetThemer >> spotterStyleFor: aBrick [

	aBrick brickRoot useVerticalLinearLayout
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
