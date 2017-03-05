Class {
	#name : #GTSpotterWidgetDarkThemer,
	#superclass : #GTSpotterWidgetThemer,
	#category : #'GT-Spotter-Theme'
}

{ #category : #values }
GTSpotterWidgetDarkThemer >> backgroundColor [
	"used as background color for all panes"
	^ UITheme current class baseColor lighter
	"^ Color r: 0.25 g: 0.25 b: 0.25"
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> borderColor [
	"color that is used for border and dividers of UI parts of Spotter
	for example divider between header and results or between preview and list"
	^ self backgroundColor lighter
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> breadcrumbItemTextColor [

	^ UITheme current textColor
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> itemActionSelectedBackgroundColor [

	^ self itemSelectedBackgroundColor slightlyDarker
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> itemHoveredBackgroundColor [

	^ self itemSelectedBackgroundColor alpha: 0.35
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> itemIconAlphaValue [

	^ 0.5
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> itemSelectedBackgroundColor [

	^ UITheme current spotterSelectionBackgroundColor 

]

{ #category : #values }
GTSpotterWidgetDarkThemer >> searchFieldTextColor [
	
	^ UITheme current textColor twiceDarker
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> spotterPreviewWidgetStyleFor: aBrick [
	
	aBrick
		borderColor: self borderColor;
		color: self backgroundColor
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> titleTextColor [

	^ self backgroundColor muchLighter
]
