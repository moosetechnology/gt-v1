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
	^ Color r: 219 g: 217 b: 217 range: 255
]

{ #category : #styles }
GTSpotterWidgetThemer >> breadcrumbItemStyleFor: aBrick [

	aBrick enable.
	aBrick renderer: (GLMRoundButtonBrickRenderer new antialiasing: true; isRoundedRight: true; isRoundedLeft: true; yourself).
	aBrick textPosition: #center.
	aBrick normalColor: Color veryVeryLightGray.
	aBrick selectedColor: Color veryVeryLightGray darker.
	
	aBrick layoutProperties marginTop: self outerBorderWidth.
	aBrick layoutProperties marginBottom: self outerBorderWidth.
	aBrick layoutProperties marginRight: self outerBorderWidth.
	
	aBrick label layoutProperties paddingLeft: self outerBorderWidth * 2.
]

{ #category : #styles }
GTSpotterWidgetThemer >> breadcrumbStyleFor: aBrick [

	aBrick color: Color white.
	
	aBrick layoutProperties marginLeft: self outerBorderWidth.
	aBrick layoutProperties marginRight: self outerBorderWidth.
]

{ #category : #styles }
GTSpotterWidgetThemer >> breadcrumbWrapperStyleFor: aBrick [

	aBrick color: self backgroundColor
]

{ #category : #values }
GTSpotterWidgetThemer >> buttonPressedColor [

	^ self backgroundColor darker
]

{ #category : #styles }
GTSpotterWidgetThemer >> categoryAmountStyleFor: aBrick [

	aBrick heightBlock: [ :aName | aName label textSize y ].
	aBrick textPosition: #rightCenter.
	aBrick textColor: self titleTextColor.
	aBrick layoutProperties marginTop: -7.
	aBrick label layoutProperties marginRight: self categoryNameMarginRight.
	aBrick label layoutProperties marginLeft: self categoryNameMarginLeft.
	aBrick label fontSize: self titleFontSize.
	aBrick label familyName: self titleFamilyName.
	aBrick color: self titleBackgroundColor.
]

{ #category : #styles }
GTSpotterWidgetThemer >> categoryCandidatesListStyleFor: aBrick [

	aBrick layoutProperties horizontalPercent: self categoryCandidatesListWidth
]

{ #category : #values }
GTSpotterWidgetThemer >> categoryCandidatesListWidth [

	^ 100 - self categoryTitleWidth "percents"
]

{ #category : #styles }
GTSpotterWidgetThemer >> categoryFirstStyleFor: aBrick [
]

{ #category : #values }
GTSpotterWidgetThemer >> categoryMarginTop [

	^ 20 "pixels"
]

{ #category : #values }
GTSpotterWidgetThemer >> categoryNameMarginLeft [

	^ 15
]

{ #category : #values }
GTSpotterWidgetThemer >> categoryNameMarginRight [

	^ 10
]

{ #category : #styles }
GTSpotterWidgetThemer >> categoryStyleFor: aBrick [

	aBrick layoutProperties marginTop: self categoryMarginTop
]

{ #category : #styles }
GTSpotterWidgetThemer >> categoryTitleNameStyleFor: aBrick [

	aBrick heightBlock: [ :aName | ((aName label textSize y * 1.2) max: self itemHeight) ceiling ].
	aBrick textPosition: #rightCenter.
	aBrick textColor: self titleTextColor.
	aBrick label layoutProperties marginRight: self categoryNameMarginRight.
	aBrick label layoutProperties marginLeft: self categoryNameMarginLeft.
	aBrick label fontSize: self titleFontSize.
	aBrick label familyName: self titleFamilyName.
	aBrick color: self titleBackgroundColor.
]

{ #category : #styles }
GTSpotterWidgetThemer >> categoryTitleStyleFor: aBrick [

	aBrick layoutProperties horizontalPercent: self categoryTitleWidth.
	aBrick layoutPolicy: GLMBrickVerticalFillLinearLayout new.
]

{ #category : #values }
GTSpotterWidgetThemer >> categoryTitleWidth [

	^ 25 "percents"
]

{ #category : #styles }
GTSpotterWidgetThemer >> closeButtonStyleFor: aBrick [

	aBrick normalImage: GLMUIThemeExtraIcons glamorousCancel.
	aBrick pressedColor: self buttonPressedColor.
	aBrick layoutProperties horizontalPercent: 0.
]

{ #category : #styles }
GTSpotterWidgetThemer >> dropDownPaneStyleFor: aBrick [

	aBrick layoutProperties: GLMBrickLayoutProperties new.
	aBrick layoutProperties verticalPercent: 100.	"will fill the rest of the space in spotter vertically"
	aBrick layoutProperties marginTop: self innerBorderWidth.
	aBrick color: self backgroundColor.
	aBrick height: 400
]

{ #category : #values }
GTSpotterWidgetThemer >> headerHeight [
	"height of the header where user enters search request"
	^ 56
]

{ #category : #styles }
GTSpotterWidgetThemer >> headerStyleFor: aBrick [

	aBrick heightBlock: [ :brick | self headerHeight ].
	aBrick color: self backgroundColor.
]

{ #category : #values }
GTSpotterWidgetThemer >> innerBorderWidth [
	"width of the border that separates panes in the spotter"
	^ 1
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

	^ self backgroundColor slightlyDarker
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
	aBrick layoutProperties horizontalPercent: 0.	"constant width"
	aBrick layoutProperties marginLeft: self titleMarginLeft.
	"margin right depends on maximal icon width and on image form width"
	aBrick layoutProperties marginRight: (self itemIconMaxWidth - aBrick normalImage width - aBrick layoutProperties marginLeft).
	aBrick layoutProperties minWidth: (aBrick normalImage width + aBrick layoutProperties horizontalMargin).
	"making icon a bit transparent"
	aBrick normalImage: (aBrick normalImage asAlphaImageMorph alpha: self itemIconAlphaValue) cachedForm
]

{ #category : #styles }
GTSpotterWidgetThemer >> itemLabelStyleFor: aBrick [

	aBrick layoutProperties horizontalPercent: 100.
	aBrick label familyName: self itemFamilyName.
	aBrick label fontSize: self itemFontSize.
	aBrick layoutProperties marginRight: self outerBorderWidth.
]

{ #category : #values }
GTSpotterWidgetThemer >> itemNormalBackgroundColor [

	^ Color transparent
]

{ #category : #styles }
GTSpotterWidgetThemer >> itemNormalStyleFor: aBrick [

	aBrick color: self itemNormalBackgroundColor.
	aBrick heightBlock: [ :anItem | self itemHeight ]
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

{ #category : #values }
GTSpotterWidgetThemer >> previewPaneWidth [
	"width in Percents of the preview pane"
	^ 57"%"
]

{ #category : #styles }
GTSpotterWidgetThemer >> resultsPaneStyleFor: aBrick [

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
	aMorph layoutProperties: GLMBrickLayoutProperties new.
	aMorph layoutProperties horizontalPercent: 100.
	aMorph layoutProperties marginLeft: self searchFieldMarginLeft.
	aMorph hResizing: #spaceFill.
	aMorph vResizing: #spaceFill.
	aMorph color: Color transparent.
	aMorph withoutAdornment.
	aMorph withGhostText: self spotterGhostText.
	aMorph ghostTextRuler fontName: self searchFieldFamilyName pointSize: self searchFieldFontSize.
	aMorph textArea font: (LogicalFont familyName: self searchFieldFamilyName pointSize: self searchFieldFontSize).
	aMorph textArea backgroundColor: Color transparent.
	aMorph autoAccept: true.
	aMorph borderColor: Color white
]

{ #category : #styles }
GTSpotterWidgetThemer >> spotterContentsStyleFor: aBrick [

	aBrick layoutProperties marginTop: self outerBorderWidth.
	aBrick layoutProperties marginBottom: self outerBorderWidth.
	aBrick layoutProperties marginLeft: self outerBorderWidth.
	aBrick layoutProperties marginRight: self outerBorderWidth.
]

{ #category : #values }
GTSpotterWidgetThemer >> spotterGhostText [

	^ 'Spotter search'
]

{ #category : #styles }
GTSpotterWidgetThemer >> spotterStyleFor: aBrick [

	aBrick brickRoot: GLMBandBrick new.
	aBrick brickRoot color: self borderColor.
]

{ #category : #styles }
GTSpotterWidgetThemer >> stepPaneStyleFor: aBrick [

	aBrick color: self borderColor
]

{ #category : #styles }
GTSpotterWidgetThemer >> stepsBandStyleFor: aBrick [

	aBrick layoutPolicy: GLMBrickHorizontalFillProportionalLinearLayout new.
	aBrick widthBlock: [ :b |  ].
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
	^ 8
]

{ #category : #values }
GTSpotterWidgetThemer >> titleMarginLeft [
	^ 20
]

{ #category : #values }
GTSpotterWidgetThemer >> titleTextColor [

	^ self titleBackgroundColor muchDarker
]
