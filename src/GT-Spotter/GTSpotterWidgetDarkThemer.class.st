"
A GTSpotterWidgetDarkThemer isasdasdasd xxasdasda
"
Class {
	#name : #GTSpotterWidgetDarkThemer,
	#superclass : #GTSpotterWidgetThemer,
	#category : #'GT-Spotter-Theme'
}

{ #category : #values }
GTSpotterWidgetDarkThemer >> backgroundColor [
	"used as background color for all panes"
	^ Color r: 0.3 g: 0.3 b: 0.3
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> borderColor [
	"color that is used for border and dividers of UI parts of Spotter
	for example divider between header and results or between preview and list"
	^ self backgroundColor darker
]

{ #category : #acessing }
GTSpotterWidgetDarkThemer >> brickThemer [

	^ GTSpotterBrickDarkThemer default
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> categoryTitleBackgroundColor [

	^ self backgroundColor alpha: 0.95
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> itemActionSelectedBackgroundColor [

	^ self itemSelectedBackgroundColor slightlyDarker
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> itemIconAlphaValue [

	^ 0.5
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> itemSelectedBackgroundColor [

	^ self backgroundColor slightlyDarker
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> itemTextColor [

	^ Color white slightlyDarker
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> searchFieldCursorColor [

	^ Color white alpha: 0.5
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> searchFieldTextColor [
	
	^ Color white slightlyDarker
]

{ #category : #values }
GTSpotterWidgetDarkThemer >> titleTextColor [

	^ self backgroundColor muchLighter
]
