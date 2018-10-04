Class {
	#name : #GTExampleMethodSpotterExtension,
	#superclass : #GTAbstractExampleMethodExtension,
	#category : #'GT-Examples-UI'
}

{ #category : #ui }
GTExampleMethodSpotterExtension >> gtSpotterFor: aStep example: aGTExample [
	self provider perform: self selector withArguments: { aStep. aGTExample }
]
