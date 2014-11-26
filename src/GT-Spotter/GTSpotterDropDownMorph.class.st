Class {
	#name : #GTSpotterDropDownMorph,
	#superclass : #GLMPagerMorph,
	#instVars : [
		'spotterModel'
	],
	#category : #'GT-Spotter-UI'
}

{ #category : #initialization }
GTSpotterDropDownMorph >> initialize [
	super initialize.
	
	self showScrollBarWhenNeeded: false
]

{ #category : #'event handling' }
GTSpotterDropDownMorph >> onStepAdded: ann [
	"as soon as step added we need to push it"
	self pushPane: (GTSpotterStepPane new stepModel: ann stepModel)
]

{ #category : #accessing }
GTSpotterDropDownMorph >> spotterModel [
	^ spotterModel
]

{ #category : #accessing }
GTSpotterDropDownMorph >> spotterModel: aModel [ 
	spotterModel := aModel.
	
	spotterModel steps do: [ :each | self pushPane: (GTSpotterStepPane new stepModel: each) ].
	
	spotterModel announcer subscribe: GTSpotterStepAdded send: #onStepAdded: to: self.
]
