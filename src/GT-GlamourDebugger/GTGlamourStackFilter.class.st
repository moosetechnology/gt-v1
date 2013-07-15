Class {
	#name : #GTGlamourStackFilter,
	#superclass : #Object,
	#category : #'GT-GlamourDebugger'
}

{ #category : #'as yet unclassified' }
GTGlamourStackFilter class >> locateBrowserContextFor: aContext [
	
	^ (aContext findContextSuchThat:  [ :ctx | 
		(ctx receiver class inheritsFrom: GLMPresentation)  and: [ ctx selector = #startOn: ] ]) 
]
