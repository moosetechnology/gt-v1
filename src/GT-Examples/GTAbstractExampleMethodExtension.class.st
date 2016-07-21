Class {
	#name : #GTAbstractExampleMethodExtension,
	#superclass : #GTAbstractExampleMethod,
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTAbstractExampleMethodExtension class >> isAbstract [
	^ self == GTAbstractExampleMethodExtension
]

{ #category : #ui }
GTAbstractExampleMethodExtension >> gtInspectorFor: composite example: aGTExample [
]

{ #category : #ui }
GTAbstractExampleMethodExtension >> gtSpotterFor: aStep example: aGTExample [
]
