Class {
	#name : #GTExampleMethodInspectorActionExtension,
	#superclass : #GTAbstractExampleMethodExtension,
	#category : #'GT-Examples-UI'
}

{ #category : #ui }
GTExampleMethodInspectorActionExtension >> gtInspectorActionFor: aGTExample [
	^ self provider perform: self selector withArguments: { aGTExample }
]
