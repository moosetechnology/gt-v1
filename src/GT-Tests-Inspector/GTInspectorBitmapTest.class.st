Class {
	#name : #GTInspectorBitmapTest,
	#superclass : #GTInspectorSmokeTest,
	#category : #'GT-Tests-Inspector'
}

{ #category : #tests }
GTInspectorBitmapTest >> objectToTest [ 
	^ ThemeIcons current pharoIcon bits
]
