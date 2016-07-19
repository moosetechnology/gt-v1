Class {
	#name : #GTAbstractExampleIcon,
	#superclass : #GTAbstractExampleObject,
	#traits : 'TGTExampleIcon',
	#classTraits : 'TGTExampleIcon classTrait',
	#category : #'GT-Examples-Utils'
}

{ #category : #testing }
GTAbstractExampleIcon class >> isAbstract [
	^ self == GTAbstractExampleIcon
]
