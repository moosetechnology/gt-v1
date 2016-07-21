Class {
	#name : #GTExampleMethodSpotter,
	#superclass : #GTAbstractExampleMethodExtension,
	#category : #'GT-Examples-Utils'
}

{ #category : #ui }
GTExampleMethodSpotter >> gtSpotterFor: aStep example: aGTExample [
	self provider perform: self selector withArguments: { aStep. aGTExample }
]
