Class {
	#name : #GTExampleMethodInspector,
	#superclass : #GTAbstractExampleMethodExtension,
	#category : #'GT-Examples-Utils'
}

{ #category : #ui }
GTExampleMethodInspector >> gtInspectorFor: aComposite example: aGTExample [
	self provider perform: self selector withArguments: { aComposite. aGTExample }
]
