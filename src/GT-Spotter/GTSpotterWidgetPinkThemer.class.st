Class {
	#name : #GTSpotterWidgetPinkThemer,
	#superclass : #GTSpotterWidgetThemer,
	#category : #'GT-Spotter-Theme'
}

{ #category : #values }
GTSpotterWidgetPinkThemer >> backgroundColor [
	"used as background color for all panes"
	
	^ (Color r: 250 g: 217 b: 222 range: 255) slightlyWhiter
]

{ #category : #values }
GTSpotterWidgetPinkThemer >> borderColor [
	"color that is used for border and dividers of UI parts of Spotter
	for example divider between header and results or between preview and list"

	^ (Color r: 229 g: 43 b: 72 range: 255) whiter whiter
]

{ #category : #values }
GTSpotterWidgetPinkThemer >> itemSelectedBackgroundColor [

	^ Color r: 248 g: 200 b: 207 range: 255
]

{ #category : #values }
GTSpotterWidgetPinkThemer >> searchFieldTextColor [
	
	^ Color r: 207 g: 25 b: 54 range: 255
]
