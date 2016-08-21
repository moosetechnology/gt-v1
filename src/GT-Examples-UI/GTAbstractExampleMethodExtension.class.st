Class {
	#name : #GTAbstractExampleMethodExtension,
	#superclass : #GTAbstractExampleMethod,
	#category : #'GT-Examples-UI'
}

{ #category : #testing }
GTAbstractExampleMethodExtension class >> isAbstract [
	^ self == GTAbstractExampleMethodExtension
]

{ #category : #ui }
GTAbstractExampleMethodExtension >> gtInspectorActionFor: aGTExample [
	^ nil
]

{ #category : #ui }
GTAbstractExampleMethodExtension >> gtInspectorFor: composite example: aGTExample [
]

{ #category : #ui }
GTAbstractExampleMethodExtension >> gtSpotterFor: aStep example: aGTExample [
]
