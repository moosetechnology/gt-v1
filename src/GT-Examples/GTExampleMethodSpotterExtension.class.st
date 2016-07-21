Class {
	#name : #GTExampleMethodSpotterExtension,
	#superclass : #GTAbstractExampleMethodExtension,
	#category : #'GT-Examples-Utils'
}

{ #category : #ui }
GTExampleMethodSpotterExtension >> gtSpotterFor: aStep example: aGTExample [
	self provider perform: self selector withArguments: { aStep. aGTExample }
]
