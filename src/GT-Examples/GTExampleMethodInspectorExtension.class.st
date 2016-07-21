Class {
	#name : #GTExampleMethodInspectorExtension,
	#superclass : #GTAbstractExampleMethodExtension,
	#category : #'GT-Examples-Utils'
}

{ #category : #ui }
GTExampleMethodInspectorExtension >> gtInspectorFor: aComposite example: aGTExample [
	self provider perform: self selector withArguments: { aComposite. aGTExample }
]
