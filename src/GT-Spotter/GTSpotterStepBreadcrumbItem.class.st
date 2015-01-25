Class {
	#name : #GTSpotterStepBreadcrumbItem,
	#superclass : #GLMBrick,
	#instVars : [
		'labelBrick',
		'triangleBrick'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #actions }
GTSpotterStepBreadcrumbItem >> hideTriangle [

	self triangleBrick color: Color transparent
]

{ #category : #initialization }
GTSpotterStepBreadcrumbItem >> initialize [
	super initialize.
	
	self
		layout: GLMBrickVerticalFillProportionalLinearLayout new;
		labelBrick: self newLabelBrick;
		triangleBrick: self newTriangleBrick
	
]

{ #category : #accessing }
GTSpotterStepBreadcrumbItem >> labelBrick [

	^ labelBrick
]

{ #category : #accessing }
GTSpotterStepBreadcrumbItem >> labelBrick: aBrick [

	labelBrick := aBrick.
	
	self theme spotterWidgetThemer breadcrumbItemLabelStyleFor: self labelBrick.
	self addBrickBack: self labelBrick
]

{ #category : #'instance creation' }
GTSpotterStepBreadcrumbItem >> newLabelBrick [

	^ GLMLabelBrick new
]

{ #category : #'instance creation' }
GTSpotterStepBreadcrumbItem >> newTriangleBrick [

	^ GLMBrick new
]

{ #category : #actions }
GTSpotterStepBreadcrumbItem >> showTriangle [

	self triangleBrick color: self theme spotterWidgetThemer breadcrumbItemBackgroundColor
]

{ #category : #accessing }
GTSpotterStepBreadcrumbItem >> text: aString [

	self labelBrick text: aString
]

{ #category : #accessing }
GTSpotterStepBreadcrumbItem >> triangleBrick [

	^ triangleBrick
]

{ #category : #accessing }
GTSpotterStepBreadcrumbItem >> triangleBrick: aBrick [

	triangleBrick := aBrick.
	
	self theme spotterWidgetThemer breadcrumbItemTriangleStyleFor: self triangleBrick.
	self addBrickBack: self triangleBrick
]
